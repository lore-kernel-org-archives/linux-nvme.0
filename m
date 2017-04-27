From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 27 Apr 2017 11:41:56 -0600
Subject: [GIT PULL] nvme updates for 4.12
In-Reply-To: <20170427173826.GA26927@infradead.org>
References: <20170427171939.tnlpqb5qmazns334@infradead.org>
 <0d1264ff-a8b6-7df5-6d8a-572525275e0c@kernel.dk>
 <20170427173826.GA26927@infradead.org>
Message-ID: <d3e3e4d4-c806-6c78-d6e5-e0939a66f8a5@kernel.dk>

On 04/27/2017 11:38 AM, Christoph Hellwig wrote:
> On Thu, Apr 27, 2017@11:36:00AM -0600, Jens Axboe wrote:
>> Pulled, but it threw two merge issues that I fixed up. Please double
>> check them.
> 
> I saw issues vs for-next, but not vs for-4.12/block, which I assumed
> was ok.

for-next is generally Linus master + block stuff. So if there are merge
issues with that, then Linus will see merge issues. Not always a
concern, but I prefer to resolve them, especially if they are
non-trivial.

-- 
Jens Axboe
