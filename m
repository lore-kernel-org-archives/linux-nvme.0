From: luzmaximilian@gmail.com (Maximilian Luz)
Date: Fri, 12 Apr 2019 22:59:10 +0200
Subject: Potential bug in queue_count_set
In-Reply-To: <20190411211557epcms2p7d5520c5762786ac4357bead574660bf6@epcms2p7>
References: <236178b1-7c56-1627-eed5-26706c60f71f@gmail.com>
 <b62dde65-1abf-1391-9de6-9bcdf6a7fa07@gmail.com>
 <d945096a-14d8-6d9f-187f-39501dfdb600@gmail.com>
 <b0d01a14-f80c-30f2-b190-d0bbe8eb6005@gmail.com>
 <CGME20190411174002epcas5p17add356b147c8c3186d7e98e411974ea@epcms2p7>
 <20190411211557epcms2p7d5520c5762786ac4357bead574660bf6@epcms2p7>
Message-ID: <01d96ef2-bada-85fe-5287-4303e14c955d@gmail.com>



On 4/11/19 11:15 PM, Minwoo Im wrote:
> I think I need to have a discussion about it, If user gives more than
> nr_possible_cpus, then:
>    - It should be reduced to a possible value by automatically without
>       any error.
>    - It should return an error to let user know.
> 
> Let's see how they think about it. Also we can have a discussion on that
> PATCH mail-loop.

Sounds good.

Maximilian
