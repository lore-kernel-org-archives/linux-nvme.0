From: andrey.v.kuzmin@gmail.com (Andrey Kuzmin)
Date: Fri, 5 Dec 2014 17:03:42 +0300
Subject: [PATCH] NVMe: Add SCSI VPD Block Limits Translation
In-Reply-To: <1417738406-517-1-git-send-email-keith.busch@intel.com>
References: <1417738406-517-1-git-send-email-keith.busch@intel.com>
Message-ID: <CANvN+emdi6+dW7YQV6+3MqZqwgiwHADTdOVswmN34p24p2U6vQ@mail.gmail.com>

On Dec 5, 2014 3:14 AM, "Keith Busch" <keith.busch@intel.com> wrote:
>
> This adds the translation for Inquriy VPD page b0 in accordance with
> the translation reference.
>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/block/nvme-scsi.c |   28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
> index d194ac2..85c4dab 100644
> --- a/drivers/block/nvme-scsi.c
> +++ b/drivers/block/nvme-scsi.c
> @@ -55,6 +55,7 @@ static int sg_version_num = 30534;    /* 2 digits for each component */
>  #define VPD_SERIAL_NUMBER                              0x80
>  #define VPD_DEVICE_IDENTIFIERS                         0x83
>  #define VPD_EXTENDED_INQUIRY                           0x86
> +#define VPD_BLOCK_LIMITS                               0xB0
>  #define VPD_BLOCK_DEV_CHARACTERISTICS                  0xB1
>
>
>  /* CDB offsets */
> @@ -132,9 +133,10 @@ static int sg_version_num = 30534; /* 2 digits for each component */
>  #define INQ_UNIT_SERIAL_NUMBER_PAGE                    0x80
>  #define INQ_DEVICE_IDENTIFICATION_PAGE                 0x83
>  #define INQ_EXTENDED_INQUIRY_DATA_PAGE                 0x86
> +#define INQ_BDEV_LIMITS_PAGE                           0xB0
>  #define INQ_BDEV_CHARACTERISTICS_PAGE                  0xB1
>  #define INQ_SERIAL_NUMBER_LENGTH                       0x14
> -#define INQ_NUM_SUPPORTED_VPD_PAGES                    5
> +#define INQ_NUM_SUPPORTED_VPD_PAGES                    6
>  #define VERSION_SPC_4                                  0x06
>  #define ACA_UNSUPPORTED                                        0
>  #define STANDARD_INQUIRY_LENGTH                                36

Are there any specific reasons for the above SPC-4 stuff to be defined
in the nvme driver instead of include/scsi where it seems to
(naturally) belong? Just my 0.02 :).

Regards,
Andrey

> @@ -747,6 +749,7 @@ static int nvme_trans_supported_vpd_pages(struct nvme_ns *ns,
>         inq_response[6] = INQ_DEVICE_IDENTIFICATION_PAGE;
>         inq_response[7] = INQ_EXTENDED_INQUIRY_DATA_PAGE;
>         inq_response[8] = INQ_BDEV_CHARACTERISTICS_PAGE;
> +       inq_response[9] = INQ_BDEV_LIMITS_PAGE;
>
>         xfer_len = min(alloc_len, STANDARD_INQUIRY_LENGTH);
>         res = nvme_trans_copy_to_user(hdr, inq_response, xfer_len);
> @@ -956,6 +959,25 @@ static int nvme_trans_ext_inq_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
>         return res;
>  }
>
> +static int nvme_trans_bdev_limits_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
> +                                       u8 *inq_response, int alloc_len)
> +{
> +       __be32 max_sectors = cpu_to_be32(queue_max_hw_sectors(ns->queue));
> +       __be32 max_discard = cpu_to_be32(ns->queue->limits.max_discard_sectors);
> +       __be32 discard_desc_count = cpu_to_be32(0x100);
> +
> +       memset(inq_response, 0, STANDARD_INQUIRY_LENGTH);
> +       inq_response[1] = VPD_BLOCK_LIMITS;
> +       inq_response[3] = 0x3c; /* Page Length */
> +       memcpy(&inq_response[8], &max_sectors, sizeof(u32));
> +       memcpy(&inq_response[20], &max_discard, sizeof(u32));
> +
> +       if (max_discard)
> +               memcpy(&inq_response[24], &discard_desc_count, sizeof(u32));
> +
> +       return nvme_trans_copy_to_user(hdr, inq_response, 0x3c);
> +}
> +
>  static int nvme_trans_bdev_char_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
>                                         int alloc_len)
>  {
> @@ -2286,6 +2308,10 @@ static int nvme_trans_inquiry(struct nvme_ns *ns, struct sg_io_hdr *hdr,
>                 case VPD_EXTENDED_INQUIRY:
>                         res = nvme_trans_ext_inq_page(ns, hdr, alloc_len);
>                         break;
> +               case VPD_BLOCK_LIMITS:
> +                       res = nvme_trans_bdev_limits_page(ns, hdr, inq_response,
> +                                                               alloc_len);
> +                       break;
>                 case VPD_BLOCK_DEV_CHARACTERISTICS:
>                         res = nvme_trans_bdev_char_page(ns, hdr, alloc_len);
>                         break;
> --
> 1.7.10.4
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
