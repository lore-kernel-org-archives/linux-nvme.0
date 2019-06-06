From: bvanassche@acm.org (Bart Van Assche)
Date: Thu, 6 Jun 2019 14:48:24 -0700
Subject: [PATCH 2/2] nvme: Set physical block size and optimal I/O size
 according to NVMe 1.4
In-Reply-To: <BYAPR04MB5749E9F546E6EA5415BEB20686170@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190606212854.122478-1-bvanassche@acm.org>
 <20190606212854.122478-3-bvanassche@acm.org>
 <BYAPR04MB5749E9F546E6EA5415BEB20686170@BYAPR04MB5749.namprd04.prod.outlook.com>
Message-ID: <969c0a9c-2e5a-b609-5c3b-411f9f2bf6ca@acm.org>

On 6/6/19 2:42 PM, Chaitanya Kulkarni wrote:
> Looks good. One quick question though do you actually have a controller
> on which you have tested this feature ?

Hi Chaitanya,

 From the cover letter of this patch series: "These patches
compile correctly but have not been tested in any other way."

Bart.
