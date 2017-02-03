From: scott.bauer@intel.com (Scott Bauer)
Date: Fri, 3 Feb 2017 12:23:26 -0700
Subject: [PATCH v5 2/4] block: Add Sed-opal library
In-Reply-To: <20170203081353.GC25892@infradead.org>
References: <1485857844-15130-1-git-send-email-scott.bauer@intel.com>
 <1485857844-15130-3-git-send-email-scott.bauer@intel.com>
 <20170203081353.GC25892@infradead.org>
Message-ID: <20170203192325.GA4148@sbauer-Z170X-UD5>

On Fri, Feb 03, 2017@12:13:53AM -0800, Christoph Hellwig wrote:
> > +config BLK_SED_OPAL
> > +        bool "Logic for interfacing with Opal enabled SEDs"
> 
> switch to tabe for indendtation for the above line, all others
> already get it right.
> 
> > +	default n
> > +	---help---
> 
> n is the default default, you can just remove it.
> 
> > +	Builds Logic for interfacing with Opal enabled controllers.
> > +	Enabling this option enables users to setup/unlock/lock
> > +	Locking ranges for SED devices using the Opal protocol.
> > +	Currently enables support on NVMe devices.
> 
> I'd drop that last line, it's just guaranteed to get stale quickly.
> 
> > +/* Enum to index OPALUID array */
> > +enum OPAL_UID {
> 
> Can you switch all the type names to lower case, e.g. opal_uid
> for this one.  I though I rought this up earlier, but it might have
> gotten lost between all the more important comments.
> 
> Note this only applies to the enum and struct type names, not the
> constants defined in the enum, those are usually all upper case by
> convention as in your code.
> 
> Also the arrays might want to use named initalizers to make the relation
> to the indices more clear, e.g.
> 
> 	[OPAL_SMUID_UID] =
> 		{ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff},
> 	...
> 
> It's a bit more verbose, but also more future-proof.  And it probably
> allows you to drop the comments explaining each array member.
> 
> > + * Structures to build and decode the Opal SSC messages
> > + * fields that are NOT really numeric are defined as u8[] to
> > + * help reduce the endianness issues
> > + */
> 
> That's normal in all on disk / protocol defintions.  I personally
> would just drop this comment, but it's not really a major issue.
> 
> > +static const u8 OPALUID[][8] = {
> 
> Variable names should be lower cases, too.  Also the magic 8 here
> is OPAL_UID_LENGTH, isn't it?
> 
> > +struct opal_dev;
> 
> We don't need the forward delcaration here, do we?
> 
> > +{
> > +	bool found_com_id = false, supported = true, single_user = false;
> > +	const struct d0_header *hdr;
> > +	const u8 *epos, *cpos;
> > +	u16 comid = 0;
> > +
> > +	epos = dev->resp;
> > +	cpos = dev->resp;
> > +	hdr = (struct d0_header *)dev->resp;
> 
> Shouldn't need the cast, and could be assigned in the variable
> declaration line.  The same thing appears in various other functions
> below.

Cast has to stay, resp isn't a void*. Resp could be a void * but dev->cmd
needs to stay a u8 * since we do a lot of inline dev->cmd[idx] = something.
We can change it after it lands.
