From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Fri, 19 Jan 2018 08:20:21 +0900
Subject: [PATCH 1/2] NVMe-CLI WDC-Plugin Add drive-essentials command
In-Reply-To: <20180118192138.32745-1-jeff.lien@wdc.com>
References: <20180118192138.32745-1-jeff.lien@wdc.com>
Message-ID: <CAA7jzteUBOcUcq6Nwb3rArkQpEaDQrVxQFwe2Emd-w_e28mrTA@mail.gmail.com>

Hi Jeff,

On Fri, Jan 19, 2018@4:21 AM, Jeff Lien <jeff.lien@wdc.com> wrote:
> Signed-off-by: Jeff Lien <jeff.lien at wdc.com>

> +       free(dataBuffer);
> +       dataBuffer = NULL;
> +
> +       /* Get Smart log page  */
> +       memset(&smart_log, 0, sizeof (struct nvme_smart_log));
> +       ret = nvme_smart_log(fd, 0xffffffff, &smart_log);

0xffffffff seems it could be replaced with NVME_NSID_ALL defined in
linux/nvme.h,
or your own WDC_DE_GLOBAL_NSID.

> +               memset(&deEssentialsList, 0, sizeof(deEssentialsList));
> +               deEssentialsList.logEntry = (WDC_DRIVE_ESSENTIALS*)calloc(1, sizeof(WDC_DRIVE_ESSENTIALS)*maxNumOfVUFiles);

_deEssentialsList.logEntry_ seems not freed after used or hardly found.

Additionally, please rebase this patch which causes errors below.
 - nvme_error_log() no longer has namespace parameter.
 - nvme_get_log() has appended parameters for LSP newly introduced in
NVMe 1.3 spec and LPO.

Nit - Indentation seems almost mixed both tab and whitespaces.
     - Few descriptions declared in (char *) could have _const_.

Thanks,
