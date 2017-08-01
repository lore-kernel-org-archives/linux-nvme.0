From: keith.busch@intel.com (Keith Busch)
Date: Tue, 1 Aug 2017 04:48:04 -0400
Subject: [PATCH V3] nvme-pci: add sgl support
In-Reply-To: <MWHPR04MB1008D3259D1E7EDB5BAC0FDD86B30@MWHPR04MB1008.namprd04.prod.outlook.com>
References: <20170726181931.21150-1-chaitanya.kulkarni@hgst.com>
 <4af4843c-1f8e-3b97-af79-ec065dbffd5b@grimberg.me>
 <MWHPR04MB1008D3259D1E7EDB5BAC0FDD86B30@MWHPR04MB1008.namprd04.prod.outlook.com>
Message-ID: <20170801084803.GB7837@localhost.localdomain>

On Tue, Aug 01, 2017@08:29:00AM +0000, Chaitanya Kulkarni wrote:
> [CK] Yes, I've observed approximately %5 better
> performance for IO sizes larger than 32k (for sgl_threshold = 32k).

Is that a physically contiguous 32k, or does each 4k require a different
SG element? Could you try to force both conditions and see how each
scenario compares with PRP?
