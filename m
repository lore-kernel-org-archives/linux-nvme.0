From: sarika.k.mehta@intel.com (Mehta, Sarika K)
Date: Tue, 5 Mar 2019 18:29:31 +0000
Subject: [Suspected-Phishing][PATCH 1/1] nvme-cli: enforce memory buffer
 for Host Identifier
In-Reply-To: <MW2PR2101MB092232E55EF05F2BD1396296D1720@MW2PR2101MB0922.namprd21.prod.outlook.com>
References: <1551004255-13562-1-git-send-email-maxg@mellanox.com>
 <d8bfd186-ba43-06e3-6471-c5b1afed60d2@mellanox.com>
 <MW2PR2101MB092232E55EF05F2BD1396296D1720@MW2PR2101MB0922.namprd21.prod.outlook.com>
Message-ID: <C8DE2563C5E3BF4785BDFAC2C64400FEDE19346F@ORSMSX113.amr.corp.intel.com>

Thanks Jeremiah. Moving you to BCC.

Thanks,
S?rik?

-----Original Message-----
From: Jeremiah Samli [mailto:jsamli@microsoft.com] 
Sent: Monday, March 04, 2019 7:44 PM
To: Max Gurtovoy <maxg at mellanox.com>; linux-nvme at lists.infradead.org; Busch, Keith <keith.busch at intel.com>; hch at lst.de; sagi at grimberg.me; Johannes Thumshirn <jthumshirn at suse.de>; Mehta, Sarika K <sarika.k.mehta at intel.com>
Cc: Aviad Yehezkel <aviadye at mellanox.com>; oren at mellanox.com; Boris Pinzur <bpinzur at mellanox.com>; Omri Kahalon <omrik at mellanox.com>
Subject: RE: [Suspected-Phishing][PATCH 1/1] nvme-cli: enforce memory buffer for Host Identifier

+ Sarika who has been working with Keith on this.

-----Original Message-----
From: Max Gurtovoy <maxg@mellanox.com>
Sent: Monday, March 4, 2019 1:21 AM
To: linux-nvme at lists.infradead.org; keith.busch at intel.com; hch at lst.de; sagi at grimberg.me; Johannes Thumshirn <jthumshirn at suse.de>
Cc: Aviad Yehezkel <aviadye at mellanox.com>; oren at mellanox.com; Boris Pinzur <bpinzur at mellanox.com>; Omri Kahalon <omrik at mellanox.com>
Subject: Re: [Suspected-Phishing][PATCH 1/1] nvme-cli: enforce memory buffer for Host Identifier

Keith/Johannes,

can you have a look on this please ?

On 2/24/2019 12:30 PM, Max Gurtovoy wrote:
> According to the NVMe spec, the NVMe Set Features command for Host 
> Identifier (fid=0x81) must use memory buffer for its attributes.
> Enforce that and set the correct data length (16 for extended Host 
> Identifier, 8 for non-extended). The data for the Host Identifier can 
> be taken from a data file or from the stdin (same as before):
> 1. stdin example:
>   - echo "host1234" | nvme set-feature /dev/nvme2n1 --feature-id=0x81
> --value=0 2. data file example:
>   - echo "host5555" > /tmp/hostid.data
>   - nvme set-feature /dev/nvme2n1 --feature-id=0x81 --value=0 
> --data=/tmp/hostid.data
>
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
> ---
>   nvme.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/nvme.c b/nvme.c
> index 8aac2ef..7897510 100644
> --- a/nvme.c
> +++ b/nvme.c
> @@ -3279,6 +3279,12 @@ static int set_feature(int argc, char **argv, struct command *cmd, struct plugin
>   	}
>   	if (cfg.feature_id == NVME_FEAT_LBA_RANGE)
>   		cfg.data_len = 4096;
> +	if (cfg.feature_id == NVME_FEAT_HOST_ID) {
> +		cfg.data_len = 8;
> +		/* check for Extended Host Identifier */
> +		if (cfg.value & 0x1)
> +			cfg.data_len = 16;
> +	}
>   	if (cfg.data_len) {
>   		if (posix_memalign(&buf, getpagesize(), cfg.data_len)) {
>   			fprintf(stderr, "can not allocate feature payload\n");
