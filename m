From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Wed, 18 Apr 2018 13:39:11 +0000
Subject: [PATCH 1/1] RDMA over Fibre Channel
In-Reply-To: <86f66430d0c577792b663226189d31a1@mail.gmail.com>
References: <20180418094240.26371-1-muneendra.kumar@broadcom.com>
 <20180418102223.GA27364@infradead.org>
 <86f66430d0c577792b663226189d31a1@mail.gmail.com>
Message-ID: <5fd3da7b3182eeb1b7416c9192202adecc7383e3.camel@wdc.com>

On Wed, 2018-04-18@17:17 +0530, Muneendra Kumar M wrote:
> Although we concur with the idea of RDMA directly over Fibre channel, the
> actual implementation addressing the above reasons requires
> standardization and coordination with FC HBA vendors and other SAN
> ecosystem players. This effort is ongoing within our organization (Brocade
> at Broadcom).

What makes you think that a new standardization effort would have to be
launched to make RDMA over FC possible? RDMA over FC was standardized a long
time ago and is called "FC-VI". Why aren't you using that standard? A quote
from the FC-VI document:

Table 1 ? VI and FC-VI functions
................................
VI function                   FC-VI equivalent
VI Message                    Exchange
Request/Response primitives   Sequence
VI Connect/Disconnect request Unsolicited control IU
VI Connect response           Solicited control IU
VI Send Data                  Solicited data IU
VI Send Response              Command status IU
VI RDMA Write Request         Solicited data IU
VI RDMA Write Response        Command status IU
VI RDMA Read Request          Unsolicited command IU
VI RDMA Read Response         Solicited data IU

See also ANSI/INCITS 357:2002, "Fibre Channel Virtual Interface Architecture
Mapping Protocol (FC-VI)", NCITS Project 1332-D, July 2000.

Bart.
