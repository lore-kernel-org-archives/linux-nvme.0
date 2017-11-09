From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Thu, 9 Nov 2017 16:42:52 +0000
Subject: [PATCH v3 0/9] Introduce per-device completion queue pools
In-Reply-To: <20171108095742.25365-1-sagi@grimberg.me>
References: <20171108095742.25365-1-sagi@grimberg.me>
Message-ID: <1510245771.2608.6.camel@wdc.com>

On Wed, 2017-11-08@11:57 +0200, Sagi Grimberg wrote:
> This is the third re-incarnation of the CQ pool patches proposed
> by Christoph and I.

Hello Sagi,

This work looks interesting to me and I think it is a good idea to introduce
a CQ pool implementation in the RDMA core. However, I have a concern about
the approach. This patch series associates a single CQ pool with each RDMA
device. Wouldn't it be better to let CQ pool users chose the CQ pool size and
to let these users manage the CQ pool lifetime instead of binding the
lifetime of a CQ pool to that of an RDMA device? RDMA drivers are loaded
during system startup. I think allocation of memory for CQ pools should be
deferred until the ULP protocol driver(s) are loaded to avoid allocating
memory for CQs while these are not in use. Additionally, on many setups each
RDMA port only runs a single ULP. I think that's another argument to let the
ULP allocate CQ pool(s) instead of having one such pool per HCA.

Bart.
