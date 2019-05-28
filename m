From: james.r.harris@intel.com (Harris, James R)
Date: Tue, 28 May 2019 21:49:55 +0000
Subject: [PATCH 1/2] nvme-rdma: fix queue mapping when queue count is
 limited
In-Reply-To: <20190524041004.23200-1-sagi@grimberg.me>
References: <20190524041004.23200-1-sagi@grimberg.me>
Message-ID: <03D3DDE9-F714-4F30-8716-BBCA97CBEDF8@intel.com>



?On 5/23/19, 9:10 PM, "Sagi Grimberg" <sagi@grimberg.me> wrote:

    When the controller supports less queues than requested, we
    should make sure that queue mapping does the right thing and
    not assume that all queues are available. This fixes a crash
    when the controller supports less queues than requested.
    
    The rules are:
    1. if no write/poll queues are requested, we assign the available queues
       to the default queue map. The default and read queue maps share the
       existing queues.
    2. if write queues are requested:
      - first make sure that read queue map gets the requested
        nr_io_queues count
      - then grant the default queue map the minimum between the requested
        nr_write_queues and the remaining queues. If there are no available
        queues to dedicate to the default queue map, fallback to (1) and
        share all the queues in the existing queue map.
    3. if poll queues are requested:
      - map the remaining queues to the poll queue map.
    
    Also, provide a log indication on how we constructed the different
    queue maps.
    
    One side-affect change is that we remove the rdma device number of
    completion vectors device limitation when setting the queue count.
    No rdma device uses managed affinity so there is no real reason as
    we cannot guarantee any vector based queue mapping. This change is
    squashed here because this patch needs to go to stable kernel and
    its simpler having it here than having it live on its own without
    a clear indication why it ended up in stable kenrels.
    
    Reported-by: Harris, James R <james.r.harris at intel.com>
    Cc: <stable at vger.kernel.org> # v5.0+
    Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

Thanks Sagi.  This works for me.

Tested-by: Jim Harris <james.r.harris at intel.com>
