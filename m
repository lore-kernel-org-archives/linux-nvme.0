From: tiwai@suse.de (Takashi Iwai)
Date: Tue, 05 Jun 2018 16:41:19 +0200
Subject: [PATCH 0/2] Documentation: add asciidoctor support
In-Reply-To: <20180412110238.30717-1-tiwai@suse.de>
References: <20180412110238.30717-1-tiwai@suse.de>
Message-ID: <s5h8t7tpa7k.wl-tiwai@suse.de>

On Thu, 12 Apr 2018 13:02:36 +0200,
Takashi Iwai wrote:
> 
> Hi,
> 
> this is a patchset to add the support for asciidoctor to generate
> documents.  asciidoc is based on python2, and its future isn't clear,
> so as a plan-B, we can use asciidoctor instead.
> 
> The asciidoctor support is opt-in, the default is still kept for
> asciidoc for now.

Just a gentle reminder about this patchset.

I've seen reviewed-by from Sagi, but couldn't find any other
reactions, also not on github repo.

Let me know if I need to fix or resend.


thanks,

Takashi


> 
> 
> thanks,
> 
> Takashi
> 
> ===
> 
> Takashi Iwai (2):
>   Documentation: fix title markers
>   Documentation: allow to format with asciidoctor
> 
>  Documentation/Makefile                   |   13 +++++++++++++
>  Documentation/asciidoctor-extensions.rb  |   29 +++++++++++++++++++++++++++++
>  Documentation/nvme-discover.txt          |    2 +-
>  Documentation/nvme-huawei-id-ctrl.txt    |    2 +-
>  Documentation/nvme-wdc-id-ctrl.txt       |    2 +-
>  Documentation/nvme-wdc-purge-monitor.txt |    2 +-
>  Documentation/nvme-wdc-purge.txt         |    2 +-
>  7 files changed, 47 insertions(+), 5 deletions(-)
> 
