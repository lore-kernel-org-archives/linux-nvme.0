From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Thu, 26 Apr 2018 18:25:38 +0000
Subject: [PATCH 3/6] ib_srpt: depend on INFINIBAND_ADDR_TRANS
In-Reply-To: <20180426181935.32977-4-gthelen@google.com>
References: <20180426181935.32977-1-gthelen@google.com>
 <20180426181935.32977-4-gthelen@google.com>
Message-ID: <ca7d760cb8b04853e94e63fadc82303a3972b289.camel@wdc.com>

On Thu, 2018-04-26@11:19 -0700, Greg Thelen wrote:
> INFINIBAND_SRPT code depends on INFINIBAND_ADDR_TRANS provided symbols.
> So declare the kconfig dependency.  This is necessary to allow for
> enabling INFINIBAND without INFINIBAND_ADDR_TRANS.

Reviewed-by: Bart Van Assche <bart.vanassche at wdc.com>
