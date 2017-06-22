/* Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.camunda.bpm.integrationtest.functional.spin.dataformat;

import org.camunda.bpm.integrationtest.functional.spin.XmlSerializable;
import org.camunda.spin.impl.json.jackson.format.JacksonJsonDataFormat;
import org.camunda.spin.spi.DataFormatConfigurator;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.module.SimpleModule;

/**
 * @author Svetlana Dorokhova.
 */
public class CustomDataFormatConfigurator implements DataFormatConfigurator<JacksonJsonDataFormat> {

  public CustomDataFormatConfigurator() {
  }

  @Override
  public Class<JacksonJsonDataFormat> getDataFormatClass() {
    return JacksonJsonDataFormat.class;
  }

  @Override
  public void configure(JacksonJsonDataFormat dataFormat) {
    ObjectMapper objectMapper = dataFormat.getObjectMapper();
    SimpleModule module = new SimpleModule();
    module.addDeserializer(XmlSerializable.class, new XmlSerializableJsonDeserializer());
    module.addSerializer(XmlSerializable.class, new XmlSerializableJsonSerializer());
    objectMapper.registerModule(module);
  }

}
