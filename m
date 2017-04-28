From: james.smart@broadcom.com (James Smart)
Date: Thu, 27 Apr 2017 20:03:12 -0700
Subject: [PATCH] nvmet core: skip flags checks on fabric commands
In-Reply-To: <20170428002056.26213-1-jsmart2021@gmail.com>
References: <20170428002056.26213-1-jsmart2021@gmail.com>
Message-ID: <979902d3-ff07-4213-6f31-11eb19ad9829@broadcom.com>

On 4/27/2017 5:20 PM, jsmart2021@gmail.com wrote:
> From: James Smart <jsmart2021 at gmail.com>
>
> The core layer validates nvme command flags (w0 byte 1) values before
> decoding opcodes. On fabric commands the flags field is reserved.
> Current validations require NVME_CMD_SGL_METABUF or NVME_CMD_SGL_METASEG
> to be set. If host sets flags to 0 as reserved field, command fails.
>
> Exclude fabric commands from flags checks.
>
> Signed-off-by: James Smart <james.smart at broadcom.com>

Please disregard. missed the static. Will repost.

Sorry for the noise.

-- james
