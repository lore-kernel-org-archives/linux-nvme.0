From: willy@linux.intel.com (Matthew Wilcox)
Date: Tue, 27 Aug 2013 10:17:57 -0400
Subject: NVME identify command data structure length
In-Reply-To: <CAB2zxrSPfCf4QVm=J__PX00ZFNU5XGehFKk4FNApMqbPS59BGA@mail.gmail.com>
References: <CAB2zxrSPfCf4QVm=J__PX00ZFNU5XGehFKk4FNApMqbPS59BGA@mail.gmail.com>
Message-ID: <20130827141757.GP4707@linux.intel.com>

On Tue, Aug 27, 2013@03:50:34PM +0530, anup shendkar wrote:
> 3. As nvme specification for IDENTIFY command says that 4096 is the
> output buffer length, we can add following code as a potential fix.

No.  The driver does not interpret the opcodes.  If you've mis-used the
ioctl, then you get to keep both pieces.

However, what we should do is check the bottom two bits of the opcode
(ie Data Transfer in Figure 38 of NVMe 1.1).  It is clearly a broken
command if the bottom two bits are zero and data_len is non-zero, or
for the bottom two bits to be non-zero and data_len to be zero.

Do you want to send a patch along those lines?

> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index ce79a59..b1c5e72 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -1416,6 +1416,11 @@ static int nvme_user_admin_cmd(struct nvme_dev *dev,
>         c.common.cdw10[4] = cpu_to_le32(cmd.cdw14);
>         c.common.cdw10[5] = cpu_to_le32(cmd.cdw15);
> 
> +       if (cmd.opcode == nvme_admin_identify) {
> +               /* NVME Identiy command always uses 4096 data buffer */
> +               cmd.data_len = 4096;
> +       }
> +
>         length = cmd.data_len;
>         if (cmd.data_len) {
>                 iod = nvme_map_user_pages(dev, cmd.opcode & 1, cmd.addr,
