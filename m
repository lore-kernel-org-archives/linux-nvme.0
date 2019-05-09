From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu, 9 May 2019 05:52:50 +0000
Subject: [PATCH 1/3] nvme: 002: fix nvmet pass data with loop
References: <20190505150611.15776-1-minwoo.im.dev@gmail.com>
 <20190505150611.15776-2-minwoo.im.dev@gmail.com>
 <SN6PR04MB45274C423AA7C3CC3DBB5ED586300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <a66b775f-9a5f-fefc-ae29-c86678e66463@gmail.com>
 <SN6PR04MB45272BEB18B3ADD95DCB42AE86300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <cfa4d48d-ce13-0ace-cf5c-a3d0d1f4cca7@gmail.com> <20190507062034.GA3748@x250>
 <e118dbb7-51a5-d013-8c85-391452846411@gmail.com>
Message-ID: <SN6PR04MB45275DE10FC6434B85227BB686330@SN6PR04MB4527.namprd04.prod.outlook.com>

On 5/7/19 3:23 AM, Minwoo Im wrote:
> On 5/7/19 3:20 PM, Johannes Thumshirn wrote:
>> On Tue, May 07, 2019@01:54:09AM +0900, Minwoo Im wrote:
>>> If Johannes who wrote these tests agrees to not check output result from
>>> nvme-cli, I'll get rid of them.
>>
>> Yes agreed. In the beginning I though of validating the nvme-cli output but
>> this would grow more and more filters, which makes it impractical.
>>
> 
> Cool, then I think I can update the pass condition of this testcase in
> other way.  Once Chaitanya gives his comment on this, I'll prepare it.
> 
I think responded to this one.
> Thanks,
> 
