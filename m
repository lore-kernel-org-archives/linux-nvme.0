From: m@bjorling.me (=?windows-1252?Q?Matias_Bj=F8rling?=)
Date: Mon, 23 Nov 2015 20:01:56 +0100
Subject: nvme lightnvm comments
In-Reply-To: <20151123154557.GA20924@infradead.org>
References: <20151120105022.GA22131@infradead.org>
 <20151121111210.GA19360@infradead.org> <565206C3.3000200@bjorling.me>
 <20151123154557.GA20924@infradead.org>
Message-ID: <565362A4.4030202@bjorling.me>

On 11/23/2015 04:45 PM, Christoph Hellwig wrote:
> On Sun, Nov 22, 2015@07:17:39PM +0100, Matias Bj?rling wrote:
>> On 11/21/2015 12:12 PM, Christoph Hellwig wrote:
>>> Btw, another one: it seems like LightNVM devices still claim to
>>> use the NVM I/O set per CAP and CC, which seems a little odd.
>>>
>>
>> Oh, where have you seen it? Thought I had it changed everywhere.
>
> nvme_configure_admin_queue still hardcodes then NVM comman set when
> enabling the controller.
>

I might be wrong. That is the normal nvme command set. It isn't the 
lightnvm command set. In the previous implementation, it was called 
NVME_CC_CSS_LIGHTNVM.
