From: tiwai@suse.de (Takashi Iwai)
Date: Thu, 12 Apr 2018 13:02:38 +0200
Subject: [PATCH 2/2] Documentation: allow to format with asciidoctor
In-Reply-To: <20180412110238.30717-1-tiwai@suse.de>
References: <20180412110238.30717-1-tiwai@suse.de>
Message-ID: <20180412110238.30717-3-tiwai@suse.de>

Add asciidoctor support.  You need to pass USE_ASCIIDOCTOR=yes to make
for enabling the feature.

Most of the rb extension code was shamelessly borrowed from git.

Signed-off-by: Takashi Iwai <tiwai at suse.de>

---
 Documentation/Makefile                  |   13 +++++++++++++
 Documentation/asciidoctor-extensions.rb |   29 +++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -35,6 +35,19 @@ MAN_REPO = ../../nvme-manpages
 
 ASCIIDOC_HTML = xhtml11
 ASCIIDOC_CONF = -f asciidoc.conf
+
+ifdef USE_ASCIIDOCTOR
+ASCIIDOC = asciidoctor
+ASCIIDOC_CONF =
+ASCIIDOC_HTML = xhtml5
+ASCIIDOC_DOCBOOK = docbook45
+ASCIIDOC_EXTRA += -acompat-mode
+ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
+ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
+ASCIIDOC_EXTRA += -amansource='NVMe'
+ASCIIDOC_EXTRA += -amanmanual='NVMe Manual'
+endif
+
 ASCIIDOC_COMMON = $(ASCIIDOC) $(ASCIIDOC_EXTRA) $(ASCIIDOC_CONF)
 TXT_TO_HTML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_HTML)
 
--- /dev/null
+++ b/Documentation/asciidoctor-extensions.rb
@@ -0,0 +1,29 @@
+require 'asciidoctor'
+require 'asciidoctor/extensions'
+
+module Nvme
+  module Documentation
+    class LinkNvmeProcessor < Asciidoctor::Extensions::InlineMacroProcessor
+      use_dsl
+
+      named :chrome
+
+      def process(parent, target, attrs)
+        if parent.document.basebackend? 'html'
+          %(<a href="#{target}.html">#{target}(#{attrs[1]})</a>\n)
+        elsif parent.document.basebackend? 'manpage'
+          "#{target}(#{attrs[1]})"
+        elsif parent.document.basebackend? 'docbook'
+          "<citerefentry>\n" \
+            "<refentrytitle>#{target}</refentrytitle>" \
+            "<manvolnum>#{attrs[1]}</manvolnum>\n" \
+          "</citerefentry>\n"
+        end
+      end
+    end
+  end
+end
+
+Asciidoctor::Extensions.register do
+  inline_macro Nvme::Documentation::LinkNvmeProcessor, :linknvme
+end
