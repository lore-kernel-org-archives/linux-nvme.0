From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 2 Nov 2017 18:15:54 +0200
Subject: [PATCH 0/3] Fix request completion holes
In-Reply-To: <20171102155156.GG18874@ziepe.ca>
References: <1509440122-1190-1-git-send-email-sagi@grimberg.me>
 <8abcde91-9150-2982-3900-078619bcdac0@mellanox.com>
 <a950a671-22a1-432c-555e-8309c8a64a88@grimberg.me>
 <d9dcdb05-d001-53d8-7ed7-5fafc1709f4a@mellanox.com>
 <20171101165036.GD1030@ziepe.ca>
 <5f3955d2-9116-5f18-2299-cc697947d599@grimberg.me>
 <20171101175819.GG1030@ziepe.ca>
 <5810bb05-fffd-a0f2-3509-9d9b89a2ef32@grimberg.me>
 <20171102151254.GE18874@ziepe.ca>
 <6626939a-3626-181f-ccea-0f6482e7a3fc@grimberg.me>
 <20171102155156.GG18874@ziepe.ca>
Message-ID: <6f19bb00-5d2d-91f4-1489-3b409b4a7c52@grimberg.me>


>>> Then it would need to signal the SEND if remote invalidate is used,
>>> otherwise it only needs to signal the local invalidate for the RKEY..
>>
>> Also if its simply using the local dma lkey without sending any rkey.
> 
> Right, OK, to be clear, my emails were only about the case where there
> was a SEND and INVALIDATE required together, I wasn't discussing SEND
> alone, that is already as good as it can be I think :)

Not arguing here :)
