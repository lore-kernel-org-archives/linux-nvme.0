From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Thu, 26 Apr 2018 18:26:24 +0000
Subject: [PATCH 6/6] IB: make INFINIBAND_ADDR_TRANS configurable
In-Reply-To: <20180426181935.32977-7-gthelen@google.com>
References: <20180426181935.32977-1-gthelen@google.com>
 <20180426181935.32977-7-gthelen@google.com>
Message-ID: <cdbccbcb15ed155243149a6ec3ee540df523990c.camel@wdc.com>

On Thu, 2018-04-26@11:19 -0700, Greg Thelen wrote:
> Allow INFINIBAND without INFINIBAND_ADDR_TRANS because fuzzing has been
> finding fair number of CM bugs.  So provide option to disable it.

Reviewed-by: Bart Van Assche <bart.vanassche at wdc.com>
