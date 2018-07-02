From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon, 2 Jul 2018 18:21:55 +0300
Subject: [PATCH v2 1/1] nvmet-rdma: Add an error flow for post_recv
 failures
In-Reply-To: <20180702131610.GF4624@lst.de>
References: <1530436824-18229-1-git-send-email-maxg@mellanox.com>
 <20180702131610.GF4624@lst.de>
Message-ID: <7252e67b-db51-992a-5657-db87e829c992@mellanox.com>



On 7/2/2018 4:16 PM, Christoph Hellwig wrote:
> On Sun, Jul 01, 2018@12:20:24PM +0300, Max Gurtovoy wrote:
>> Posting receive buffer operation can fail, thus we should make
>> sure to have an error flow during initialization phase. While
>> we're here, add a debug print in case of a failure.
>>
>> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
> 
> Looks fine to me.  Do you see an urgent enough issue to queue this
> up for 4.18 or can it wait for 4.19?
> 

I don't think it's urgent.
