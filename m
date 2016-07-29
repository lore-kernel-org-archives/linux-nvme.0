From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Fri, 29 Jul 2016 13:18:10 -0700
Subject: [PATCH v1] nvme-cli: user-defined hostnqn option for discover
In-Reply-To: <93cf2d21-d21e-a55f-9535-5329dc729fe0@grimberg.me>
References: <1469742446-13416-1-git-send-email-james_p_freyensee@linux.intel.com>
 <1469742446-13416-2-git-send-email-james_p_freyensee@linux.intel.com>
 <93cf2d21-d21e-a55f-9535-5329dc729fe0@grimberg.me>
Message-ID: <1469823490.18704.25.camel@linux.intel.com>

On Fri, 2016-07-29@23:04 +0300, Sagi Grimberg wrote:
> Hey Jay,
> 
> > The nvme-cli will always use the default hostnqn
> > in /dev/nvme-fabrics  for the discovery query, even though
> > both the NVMe Target and NVMe Host rdma implementations allow
> > user-defined hostnqn naming.
> > 
> > For example, this is the current, somewhat broken behavior if you
> > used your own hostnqn provision naming on the NVMe kernel target:
> > 
> > nvme discover /dev/nvme-fabrics  -t rdma --traddr=192.168.1.3 -
> > -trsvcid=4420
> > 
> > in dmesg:
> > [591910.025779] nvme nvme0: Connect Invalid Data Parameter, hostnqn
> > "nqn.2014-08.org.nvmexpress:NVMf:uuid:a2d7752c-a31b-477a-a003
> > -31a5e1c424a9"
> > 
> > New, fixed behavior introduced by this patch:
> > 
> > [root at fedora23-fabrics-host1 nvme-cli]# nvme discover  -t rdma -
> > -traddr=192.168.1.3 --trsvcid=4420 --hostnqn=host1-rogue-nqn
> > 
> > Discovery Log Number of Records 1, Generation counter 10
> > =====Discovery Log Entry 0======
> > trtype:  ipv4
> > adrfam:  rdma
> > nqntype: 2
> > treq:    0
> > portid:  1
> > trsvcid: 4420
> > subnqn:  nullside-nqn
> > traddr:  192.168.1.3
> > rdma_prtype: 0
> > rdma_qptype: 0
> > rdma_cms:    0
> > rdma_pkey: 0x0000
> > [root at fedora23-fabrics-host1 nvme-cli]#
> > 
> > changes since v0:
> >   changed short 'h' option to 'q'
> 
> We usually keep the change revisions under the '---'
> separator so it won't appear on the git logs...
> 
> > 
> > Signed-off-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
> > ---
> 
> Here...
> 
> >  fabrics.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/fabrics.c b/fabrics.c
> > index 3666a01..41a80df 100644
> > --- a/fabrics.c
> > +++ b/fabrics.c
> > @@ -49,6 +49,7 @@ struct config {
> >  	char *transport;
> >  	char *traddr;
> >  	char *trsvcid;
> > +	char *hostnqn;
> >  	char *raw;
> >  	char *device;
> >  } cfg = { 0 };
> > @@ -395,6 +396,14 @@ static int build_options(char *argstr, int
> > max_len)
> >  		max_len -= len;
> >  	}
> > 
> > +	if (cfg.hostnqn) {
> > +		len = snprintf(argstr, max_len, ",hostnqn=%s",
> > cfg.hostnqn);
> > +		if (len < 0)
> > +			return -EINVAL;
> > +		argstr += len;
> > +		max_len -= len;
> > +	}
> > +
> >  	return 0;
> >  }
> > 
> > @@ -525,6 +534,8 @@ int discover(const char *desc, int argc, char
> > **argv, bool connect)
> >  			"transport address" },
> >  		{"trsvcid", 's', "LIST", CFG_STRING, &cfg.trsvcid,
> > required_argument,
> >  			"transport service id (e.g. IP port)" },
> > +		{"hostnqn", 'q', "LIST", CFG_STRING, &cfg.hostnqn,
> > required_argument,
> > +			"user-defined hostnqn (if default not
> > used)" },
> >  		{"raw", 'r', "LIST", CFG_STRING, &cfg.raw,
> > required_argument,
> >  			"raw output file" },
> >  		{0},
> > 
> 
> Can you just add it to connect as well and add Roy's
> sign-off-by tag? No reason to keep them apart.

I think we should have two separate patches, one for discover, and one
for connect because they are two different functions for nvme-cli.  And
it would be good to have separate documentation bug/usage in the patch 
since man pages aren't written for these commands yet.

I can do all the other changes, no problem, thanks!  I'll send out a
new patch revision soon.

J

> 
> Otherwise, looks good,
> 
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
