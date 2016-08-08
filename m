From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Mon, 08 Aug 2016 14:37:47 -0700
Subject: [PATCH v2 nvme-cli 4/4] fabrics: Take the hostnqn parameter
 from a conf file if not given
In-Reply-To: <20160808133658.GC19826@lst.de>
References: <1470657480-5868-1-git-send-email-sagi@grimberg.me>
 <1470657480-5868-5-git-send-email-sagi@grimberg.me>
 <20160808133658.GC19826@lst.de>
Message-ID: <1470692267.4368.32.camel@linux.intel.com>

On Mon, 2016-08-08@15:36 +0200, Christoph Hellwig wrote:
> On Mon, Aug 08, 2016@02:58:00PM +0300, Sagi Grimberg wrote:
> > 
> > In order to allow persistent hostnqns, take the hostnqn parameter
> > for /etc/nvme/hostnqn if exists.
> > 
> > Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> > ---
> > ?fabrics.c | 22 +++++++++++++++++++++-
> > ?1 file changed, 21 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fabrics.c b/fabrics.c
> > index 54ed8e17b527..90308f07d0fb 100644
> > --- a/fabrics.c
> > +++ b/fabrics.c
> > @@ -57,6 +57,7 @@ struct config {
> > ?#define BUF_SIZE		4096
> > ?#define PATH_NVME_FABRICS	"/dev/nvme-fabrics"
> > ?#define PATH_NVMF_DISC		"/etc/nvme/nvmf_disc"
> > +#define PATH_NVMF_HOSTNQN	"/etc/nvme/hostnqn"
> > ?#define MAX_DISC_ARGS		10
> > ?
> > ?enum {
> > @@ -405,6 +406,25 @@ static void save_discovery_log(struct
> > nvmf_disc_rsp_page_hdr *log, int numrec)
> > ?	close(fd);
> > ?}
> > ?
> > +static int nvmf_hostnqn_file(void)
> > +{
> > +	FILE *f;
> > +	char hostnqn[255];
> > +
> > +	f = fopen(PATH_NVMF_HOSTNQN, "r");
> > +	if (f == NULL)
> > +		return false;
> > +
> > +	if (fgets(hostnqn, sizeof(hostnqn), f) == NULL)
> > +		return false;
> > +
> > +	cfg.hostnqn = strdup(hostnqn);
> > +	if (!cfg.hostnqn)
> > +		return false;
> > +
> > +	return true;
> 
> No fclose???The leak probably isn't bad for a short running program,
> but sooner or later someone is going to turn it into a library.
> 
> Also shouldn't we just read the 223 bytes of the actual NQN value
> instead
> of the on the wire field length? (which should be 256 anyway IIRC).

That's true, nqn names are 223, unless you have to store the name and
keep it byte-aligned, then having a variable with length 256 is more
appropriate, but then you'll need #define's, 1 for the NQN length, one
to define the array (reminder to null-terminate the string too).

> 
