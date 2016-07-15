From: mlin@kernel.org (Ming Lin)
Date: Fri, 15 Jul 2016 10:01:25 -0700
Subject: disconnecting an NVMF device while it is in use
In-Reply-To: <010b01d1dddd$5b619dd0$1224d970$@opengridcomputing.com>
References: <010b01d1dddd$5b619dd0$1224d970$@opengridcomputing.com>
Message-ID: <CAF1ivSa4usXEX+qFJLnU-AeUEvmYj_BuP1gJXKJ6Fzm+OHinrQ@mail.gmail.com>

On Thu, Jul 14, 2016@7:38 AM, Steve Wise <swise@opengridcomputing.com> wrote:
> Hey Christoph,
>
> I notice that 'nvme disconnect -d nvme0n1' works even when the device is mounted
> and in use by applications.  Is this the expected/indented behavior?

Right now, it's same as you do "echo > /sys/class/nvme/nvme0/delete_controller"

We may need to add more checks to the tool ...
