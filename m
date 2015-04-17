From: m@bjorling.me (=?windows-1252?Q?Matias_Bj=F8rling?=)
Date: Fri, 17 Apr 2015 10:15:46 +0200
Subject: [PATCH 1/5 v2] blk-mq: Add prep/unprep support
In-Reply-To: <20150417063439.GB389@infradead.org>
References: <1429101284-19490-1-git-send-email-m@bjorling.me>
 <1429101284-19490-2-git-send-email-m@bjorling.me>
 <20150417063439.GB389@infradead.org>
Message-ID: <5530C132.30107@bjorling.me>

On 04/17/2015 08:34 AM, Christoph Hellwig wrote:
> On Wed, Apr 15, 2015@02:34:40PM +0200, Matias Bj??rling wrote:
>> Allow users to hook into prep/unprep functions just before an IO is
>> dispatched to the device driver. This is necessary for request-based
>> logic to take place at upper layers.
>
> I don't think any of this logic belongs into the block layer.  All this
> should be library functions called by the drivers.
>

Just the prep/unprep, or other pieces as well?

I like that struct request_queue has a ref to struct nvm_dev, and the 
variables in request and bio to get to the struct is in the block layer.

In the future, applications can have an API to get/put flash block 
directly. (using the blk_nvm_[get/put]_blk interface).
