From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 13 May 2019 16:32:01 +0000
Subject: [PATCH] nvme-core: trace discovery log change AEN
References: <20190506193320.30884-1-chaitanya.kulkarni@wdc.com>
 <20190513132401.GA2661@infradead.org>
Message-ID: <SN6PR04MB452729CE574409342C30978F860F0@SN6PR04MB4527.namprd04.prod.outlook.com>

On 05/13/2019 06:24 AM, Christoph Hellwig wrote:
>>   		trace_nvme_async_event(ctrl, aer_notice_type);
>>   		queue_work(nvme_wq, &ctrl->fw_act_work);
>>   		break;
>> +	case NVME_AER_NOTICE_DISC_CHANGED:
>> +		trace_nvme_async_event(ctrl, aer_notice_type);
>> +		break;
>>   #ifdef CONFIG_NVME_MULTIPATH
>>   	case NVME_AER_NOTICE_ANA:
>>   		trace_nvme_async_event(ctrl, aer_notice_type);
>
> What about just moving the trace_nvme_async_event call before the
> switch statement?
>

That is something I avoided since for default case we don't want to 
trace but dev_warn.

But seems like we are okay with trace and dev_warn I'll send a V2.
