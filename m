From: james.r.harris@intel.com (Harris, James R)
Date: Tue, 28 May 2019 21:50:40 +0000
Subject: [PATCH 2/2] nvme-tcp: fix queue mapping when queue count is
 limited
In-Reply-To: <20190524041004.23200-2-sagi@grimberg.me>
References: <20190524041004.23200-1-sagi@grimberg.me>
 <20190524041004.23200-2-sagi@grimberg.me>
Message-ID: <F5720435-0411-4AFF-9263-55879768708B@intel.com>



?On 5/23/19, 9:10 PM, "Sagi Grimberg" <sagi@grimberg.me> wrote:

    When the controller supports less queues than requested, we
    should make sure that queue mapping does the right thing and
    not assume that all queues are available. This fixes a crash
    when the controller supports less queues than requested.
    
    The rules are:
    1. if no write queues are requested, we assign the available queues
       to the default queue map. The default and read queue maps share the
       existing queues.
    2. if write queues are requested:
      - first make sure that read queue map gets the requested
        nr_io_queues count
      - then grant the default queue map the minimum between the requested
        nr_write_queues and the remaining queues. If there are no available
        queues to dedicate to the default queue map, fallback to (1) and
        share all the queues in the existing queue map.
    
    Also, provide a log indication on how we constructed the different
    queue maps.
    
    Reported-by: Harris, James R <james.r.harris at intel.com>
    Cc: <stable at vger.kernel.org> # v5.0+
    Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

Thanks Sagi.  This works too.

Tested-by: Jim Harris <james.r.harris at intel.com>
