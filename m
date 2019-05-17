From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Fri, 17 May 2019 16:28:43 +0000
Subject: [PATCH RFC 0/4] nvmet: add support for port based io priority
References: <20190516032109.13048-1-chaitanya.kulkarni@wdc.com>
 <20190517094545.GA26412@infradead.org>
Message-ID: <SN6PR04MB4527B78B40C2B1D11355FA9F860B0@SN6PR04MB4527.namprd04.prod.outlook.com>

On 5/17/19 2:45 AM, Christoph Hellwig wrote:
> On Wed, May 15, 2019@08:21:04PM -0700, Chaitanya Kulkarni wrote:
>> Any feedback is welcome, I'd like to understand if this approach is desirable,
>> if not then what is the right way to use the io priorities on that target side
>> so that NVMeOF target can take advantage of the scheduler infrastructure ?
> I don't really see the point.  Why would we treat I/O differently
> depending on which port it came into?  Until NVMe has an actually
> working priority scheme trying to hack support into our infrastructure
> seems rather futile.
>
Okay, thanks for the reply Christoph. Quick question, when you mention

"Until NVMe has an actually working priority" -> host side support for

priority based block layer request -> NVMe Request processing with

having weighted round robin priority SQ for NVMe Host  ?
