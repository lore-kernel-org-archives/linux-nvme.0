From: davidc502@tds.net (davidc502)
Date: Fri, 26 Jul 2019 08:30:21 -0500
Subject: fstrim error - AORUS NVMe Gen4 SSD
In-Reply-To: <20190724213054.GA5921@localhost.localdomain>
References: <fb510e33-5c81-6d62-fcde-a2989b3a1a8f@tds.net>
 <20190723021928.GF30776@ming.t460p>
 <4a7ec7aa-f6ee-f9dc-4a17-38f2b169c721@tds.net>
 <20190723043803.GB13829@ming.t460p>
 <20190724213054.GA5921@localhost.localdomain>
Message-ID: <f3c74f5d-12c8-d7cf-2d7b-c06f04f4b738@tds.net>

Hello,

On 7/24/19 4:30 PM, Keith Busch wrote:
> On Tue, Jul 23, 2019@12:38:04PM +0800, Ming Lei wrote:
>>  From the IO trace, discard command(nvme_cmd_dsm) is failed:
>>
>>    kworker/15:1H-462   [015] .... 91814.342452: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=7, cmdid=552, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_dsm nr=0, attributes=4)
>>            <idle>-0     [013] d.h. 91814.342708: nvme_complete_rq: nvme0: disk=nvme0n1, qid=7, cmdid=552, res=0, retries=0, flags=0x0, status=8198
>>
>> And the returned error code is 0x8198, I am not sure how to parse the
>> 'Command Specific Status Values' of 0x98, maybe Christoph, Keith or our other
>> NVMe guys can help to understand the failure.
> The 198h status code is still marked reserved in the latest spec for an
> NVM command set, so not sure what to make of it. I think we would have
> to refer back to the vendor.

Thank you? for taking a look at this. I guess my question would be if 
you have a vehicle in place to be able to refer back to the vendor?

David
