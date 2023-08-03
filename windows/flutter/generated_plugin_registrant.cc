//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <modal_progress_hud_nsn/modal_progress_hud_nsn_plugin_c_api.h>
#include <pdfx/pdfx_plugin.h>
#include <printing/printing_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  ModalProgressHudNsnPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("ModalProgressHudNsnPluginCApi"));
  PdfxPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("PdfxPlugin"));
  PrintingPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("PrintingPlugin"));
}
