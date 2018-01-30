From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 30 Jan 2018 11:51:12 -0600
Subject: Reconnect on RDMA device reset
In-Reply-To: <1517333096.27592.281.camel@redhat.com>
References: <CADZhsQqDFc1NWmsihOwki8_2Zj0HuYKC_N_x0jMnCtU9Rww1UA@mail.gmail.com>
 <f0a14240-1566-1bae-1b9f-21880bc3f3a0@grimberg.me>
 <CADZhsQqvK0LMd9sfxzz+x_5qVnoi4FP0FCFMsTPjpeXyqfXKew@mail.gmail.com>
 <77cef33e-a563-97fc-7ba6-69f220f1be84@grimberg.me>
 <1516904022.27592.187.camel@redhat.com>
 <26056a83-2f81-6b56-7bbf-fcecfc4518d6@grimberg.me>
 <1517264899.27592.277.camel@redhat.com>
 <CADZhsQpWXQQ2dKxAorGMhk7HFvqoQ2Y5LxVKt66XjkcUbEuXpA@mail.gmail.com>
 <1517333096.27592.281.camel@redhat.com>
Message-ID: <038501d399f2$eb2740f0$c175c2d0$@opengridcomputing.com>

> 
> In my original email, I pointed out that I didn't know how the NVMe over
> Fabrics was doing addressing.  If it were like SRP, then it wouldn't
> work because the device GUID is part of the addressing scheme, so a new
> device wouldn't automatically show as matching that address.  If,
> however, you use IP like iSER, then yes, I agree fully you can just test
> the ability to route over the new device using the IP address and
> restore if it works.

NVME-oF/rdma uses the rdma_cm with ip addresses, ip ports, etc...
