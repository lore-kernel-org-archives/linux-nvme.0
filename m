From: chuck.lever@oracle.com (Chuck Lever)
Date: Thu, 16 Feb 2017 12:59:24 -0500
Subject: [PATCH rfc 0/4] Introduce a new helper for parsing ipv[4|6]:port
 to socket address
In-Reply-To: <8dc41cfc-85b2-fb42-61b0-5be499fa7ad0@grimberg.me>
References: <1487267017-29904-1-git-send-email-sagi@grimberg.me>
 <AD117189-9D24-4C5C-9751-9EA6B27575B1@oracle.com>
 <8dc41cfc-85b2-fb42-61b0-5be499fa7ad0@grimberg.me>
Message-ID: <EB281BA3-28DB-4DBA-BA3B-31A98BC0D44E@oracle.com>


> On Feb 16, 2017,@12:53 PM, Sagi Grimberg <sagi@grimberg.me> wrote:
> 
> Hey Chuck,
> 
>>> As a side-effect, this set adds ipv6 support for nvme over fabrics.
>>> I also converted iscsi target and plan to convert nfs/cifs next but
>>> wanted to get some feedback before doing that.
>> 
>> At least NFS/RDMA already supports IPv6. You might not need many
>> changes there, but I'll hold off on further comments.
> 
> Yea, I wanted to get all the rpc_pton/rpc_ntop (which handle both
> ipv4 and ipv6 with scopes) converted to use a common helper.

RPC is dealing with universal addresses, which are not quite the
same as IP presentation addresses. The port number is expressed
as:

  hi8.lo8

And universal IPv6 addresses don't have a mechanism for conveying
scope information.


--
Chuck Lever
