From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Mon, 08 Aug 2016 14:13:33 -0700
Subject: [PATCH RFC nvme-cli 4/4] fabrics: Allow discover params to come
 from a conf file
In-Reply-To: <1470572365-20674-5-git-send-email-sagi@grimberg.me>
References: <1470572365-20674-1-git-send-email-sagi@grimberg.me>
 <1470572365-20674-5-git-send-email-sagi@grimberg.me>
Message-ID: <1470690813.4368.15.camel@linux.intel.com>

On Sun, 2016-08-07@15:19 +0300, Sagi Grimberg wrote:

I think it's a good idea! ?A few minor things.

> Allow the user to just run "nvme discover" or "nvme connect-all"
> in case it finds a default /etc/nvme/nvmf_disc conf file.
> 

1. I think the "official trademark" of NVMe-over-Fabrics is NVMeo-F.
?So maybe tweak the conf file to /etc/nvme/nvmeof_disc (the dash
between the o and F is weird and would look dumb here).

2. Be nice to see a quick documentation example of contents of the conf
file in this patch as we don't have any documentation yet (this way
someone, not necessarily the author of this patch, can more easily
write the documentation).

Jay
