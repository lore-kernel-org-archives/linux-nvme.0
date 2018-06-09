From: maxg@mellanox.com (Max Gurtovoy)
Date: Sat, 9 Jun 2018 04:33:58 +0300
Subject: [PATCH 08/17] nvme: limit integrity segments to be <= data
 segments
In-Reply-To: <yq17ena9mxc.fsf@oracle.com>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
 <1527436222-15494-9-git-send-email-maxg@mellanox.com>
 <19c8562a-8478-196c-c9f5-385d2076448e@grimberg.me>
 <f7bf4e84-f403-7576-299f-63b0c4aa6f1b@mellanox.com>
 <yq17ena9mxc.fsf@oracle.com>
Message-ID: <694e0f4e-bf79-6139-e5ba-86c01fcce4b2@mellanox.com>



On 6/8/2018 2:50 AM, Martin K. Petersen wrote:
> 
> Max,
> 
>> This is for good practice, I don't think the block layer will/can send
>> us more integrity_segments than data_segments.
> 
> They are orthogonal. The number of integrity segments is gated by the
> max_integrity_segments queue limit.
> 

I agree, but do you think it's reasonable to set max_integrity_segments 
 > max_segments ?
