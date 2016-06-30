From: mlin@kernel.org (Ming Lin)
Date: Thu, 30 Jun 2016 15:19:08 -0700
Subject: NVMeoF multi-path setup
In-Reply-To: <1467323858.15863.3.camel@ssi>
References: <CAF1ivSbe+NboO+nbiWfEijHFJPd-AgNa=4AvWT24-HjH8A_izw@mail.gmail.com>
 <1467323858.15863.3.camel@ssi>
Message-ID: <CAF1ivSa_JnTXLCVaLQ9v92KbUuvKRR8zPZsrc-7XL=5zZEMdhQ@mail.gmail.com>

On Thu, Jun 30, 2016@2:57 PM, Ming Lin <mlin@kernel.org> wrote:
>
> There are two problems:
>
> 1. there is no "/block/" in the path
>
> /sys/devices/virtual/nvme-fabrics/block/nvme0/nvme0n1

Typo, the path is:
/sys/devices/virtual/nvme-fabrics/ctl/nvme0/nvme0n1

>
> 2. nvme was blacklisted.
