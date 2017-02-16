From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 16 Feb 2017 20:11:27 +0200
Subject: [PATCH rfc 0/4] Introduce a new helper for parsing ipv[4|6]:port
 to socket address
In-Reply-To: <EB281BA3-28DB-4DBA-BA3B-31A98BC0D44E@oracle.com>
References: <1487267017-29904-1-git-send-email-sagi@grimberg.me>
 <AD117189-9D24-4C5C-9751-9EA6B27575B1@oracle.com>
 <8dc41cfc-85b2-fb42-61b0-5be499fa7ad0@grimberg.me>
 <EB281BA3-28DB-4DBA-BA3B-31A98BC0D44E@oracle.com>
Message-ID: <34a7fa67-2b72-aaa8-1c66-cfdd5d041124@grimberg.me>


>> Yea, I wanted to get all the rpc_pton/rpc_ntop (which handle both
>> ipv4 and ipv6 with scopes) converted to use a common helper.
>
> RPC is dealing with universal addresses, which are not quite the
> same as IP presentation addresses. The port number is expressed
> as:
>
>   hi8.lo8

I noticed that, that's why there will be some processing in
sunrpc to construct a port string to a generic helper (if it chooses to
use it).

> And universal IPv6 addresses don't have a mechanism for conveying
> scope information.

I do see scope handling in rpc_pton6 code if provided...
