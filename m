From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Tue, 7 May 2019 19:23:00 +0900
Subject: [PATCH 1/3] nvme: 002: fix nvmet pass data with loop
In-Reply-To: <20190507062034.GA3748@x250>
References: <20190505150611.15776-1-minwoo.im.dev@gmail.com>
 <20190505150611.15776-2-minwoo.im.dev@gmail.com>
 <SN6PR04MB45274C423AA7C3CC3DBB5ED586300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <a66b775f-9a5f-fefc-ae29-c86678e66463@gmail.com>
 <SN6PR04MB45272BEB18B3ADD95DCB42AE86300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <cfa4d48d-ce13-0ace-cf5c-a3d0d1f4cca7@gmail.com> <20190507062034.GA3748@x250>
Message-ID: <e118dbb7-51a5-d013-8c85-391452846411@gmail.com>

On 5/7/19 3:20 PM, Johannes Thumshirn wrote:
> On Tue, May 07, 2019@01:54:09AM +0900, Minwoo Im wrote:
>> If Johannes who wrote these tests agrees to not check output result from
>> nvme-cli, I'll get rid of them.
> 
> Yes agreed. In the beginning I though of validating the nvme-cli output but
> this would grow more and more filters, which makes it impractical.
> 

Cool, then I think I can update the pass condition of this testcase in 
other way.  Once Chaitanya gives his comment on this, I'll prepare it.

Thanks,
