From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Mon, 29 Aug 2016 11:52:07 -0700
Subject: [PATCH v2] nvme-cli/fabrics: Add nr_io_queues parameter to
 connect command
In-Reply-To: <20160829155725.A031AE08C5@smtp.ogc.us>
References: <20160829155725.A031AE08C5@smtp.ogc.us>
Message-ID: <1472496727.2816.27.camel@linux.intel.com>

On Mon, 2016-08-29@08:53 -0700, Steve Wise wrote:
> Added 'nr-io-queues' to 'connect' command so users can specify the
> number
> of io queues to allocate.
> 
> usage examples:
> 
> nvme connect --transport=rdma --nr-io-queues=8 --trsvcid=4420 --
> traddr=10.0.1.14 --nqn=test-nvme
> nvme connect -t rdma -i 8 -s 4420 -a 10.0.1.14 -n test-nvme
> 
> Signed-off-by: Steve Wise <swise at opengridcomputing.com>
> ---
> 
> Changes since v1:
> 
> -Q -> -i
> nr_io_queues -> nr-io-queues
> 
> ---
> ?fabrics.c | 11 +++++++++++
> ?1 file changed, 11 insertions(+)
> 
> diff --git a/fabrics.c b/fabrics.c
> index 942e987..18e961c 100644
> --- a/fabrics.c
> +++ b/fabrics.c
> @@ -50,6 +50,7 @@ struct config {
> ?	char *traddr;
> ?	char *trsvcid;
> ?	char *hostnqn;
> +	char *nr_io_queues;

I just noticed that the 'nr_io_queues' parameter type used in the host
driver code fabrics.c is unsigned int. ?Would there be a truncation
problem here, like say someone wants to do:

nvme connect?--nr-io-queues=256

??

maybe nr_io_queues here also needs to be of type unsigned int.

Other than that, I'm fine with the changes.

> ?	char *raw;
> ?	char *device;
> ?} cfg = { 0 };
> @@ -481,6 +482,14 @@ static int build_options(char *argstr, int
> max_len)
> ?		max_len -= len;
> ?	}
> ?
> +	if (cfg.nr_io_queues) {
> +		len = snprintf(argstr, max_len, ",nr_io_queues=%s",
> cfg.nr_io_queues);
> +		if (len < 0)
> +			return -EINVAL;
> +		argstr += len;
> +		max_len -= len;
> +	}
> +
> ?	return 0;
> ?}
> ?
> @@ -713,6 +722,8 @@ int connect(const char *desc, int argc, char
> **argv)
> ?			"transport service id (e.g. IP port)" },
> ?		{"hostnqn", 'q', "LIST", CFG_STRING, &cfg.hostnqn,
> required_argument,
> ?			"user-defined hostnqn" },
> +		{"nr-io-queues", 'i', "LIST", CFG_STRING,
> &cfg.nr_io_queues, required_argument,
> +			"number of io queues to use (default is core
> count)" },
> ?		{0},
> ?	};
> ?
