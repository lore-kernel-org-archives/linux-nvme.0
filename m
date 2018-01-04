From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 4 Jan 2018 19:04:19 +0200
Subject: [PATCH 1/1] nvme: Modify the debug level for setting shutdown
 timeout
In-Reply-To: <20180104100440.GC4436@lst.de>
References: <1514727207-8460-1-git-send-email-maxg@mellanox.com>
 <20180104100440.GC4436@lst.de>
Message-ID: <b46266c8-e239-ac12-d66e-33d613de597b@mellanox.com>



On 1/4/2018 12:04 PM, Christoph Hellwig wrote:
> On Sun, Dec 31, 2017@03:33:27PM +0200, Max Gurtovoy wrote:
>> When an NVMe controller reports RTD3 Entry Latency larger than
>> the value of shutdown_timeout module parameter, we update the
>> shutdown_timeout accordingly to honor RTD3 Entry Latency. Use an
>> Informational debug level instead of a Warning level for it.
>>
>> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
> 
> I'm ok with just info, but in the end it seems like a pretty
> buggy device..
> 

but shutdown_timeout is a module param that one can set to be 10 secs 
(for example) and then it might be == transition_time and we won't see 
the print. Then is it not a buggy device anymore ? :)
