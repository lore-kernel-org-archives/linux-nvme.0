From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 11 Aug 2016 09:34:41 -0600
Subject: [PATCH v2] nvme: Suspend all queues before deletion
In-Reply-To: <87oa4zpivj.fsf@linux.vnet.ibm.com>
References: <1469812557-9809-1-git-send-email-krisman@linux.vnet.ibm.com>
 <20160802222340.GA28486@localhost.localdomain>
 <87h9b2k3fl.fsf_-_@linux.vnet.ibm.com>
 <20160804210752.GA7159@localhost.localdomain>
 <87oa4zpivj.fsf@linux.vnet.ibm.com>
Message-ID: <ff47dd4c-b55a-b5a0-53db-a290d87a537c@kernel.dk>



On 08/11/2016 06:53 AM, Gabriel Krisman Bertazi wrote:
> Keith Busch <keith.busch at intel.com> writes:
>
>> On Tue, Aug 02, 2016@11:10:38PM -0300, Gabriel Krisman Bertazi wrote:
>>> Yes, that approach seems to be ok. Please take the tested v2 below, in
>>> which I apply your suggestion, as well as clean up a bit the code in
>>> nvme_disable_io_queues and simplify the logic a bit.
>>
>> The new patch looks good to me.
>
> Hi, any chance we can get this in for 4.8-rc2 or 4.8-rc3?  It fixes
> important bugs for us.

I'll queue it up for 4.8.

-- 
Jens Axboe
