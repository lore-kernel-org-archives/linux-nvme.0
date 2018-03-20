From: muthucrazy90@gmail.com (muthu crazy)
Date: Tue, 20 Mar 2018 09:51:58 +0530
Subject: Nvme over fabrics controller reset issue
Message-ID: <CADLzrv8jrv4SMYa9BOFOi4rkyBkfYQD5QJ64QVqyXrCnDddVKg@mail.gmail.com>

Hi All,

I found a strange behaviour when I used NVMe Fabrics target.  From
Host I sent a Set property command to make CC.EN=0. And then again I
made CC.EN=1. I was expecting all the transport and nvme queus will be
deleted. But didn't happen, rather queus are retained connection is
still active.

 Isn't violation of NVMe spec. Is there any reason for implementing this way?

Thanks and regards,
Muthu
