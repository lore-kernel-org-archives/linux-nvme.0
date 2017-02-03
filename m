From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 3 Feb 2017 00:13:53 -0800
Subject: [PATCH v5 2/4] block: Add Sed-opal library
In-Reply-To: <1485857844-15130-3-git-send-email-scott.bauer@intel.com>
References: <1485857844-15130-1-git-send-email-scott.bauer@intel.com>
 <1485857844-15130-3-git-send-email-scott.bauer@intel.com>
Message-ID: <20170203081353.GC25892@infradead.org>

> +config BLK_SED_OPAL
> +        bool "Logic for interfacing with Opal enabled SEDs"

switch to tabe for indendtation for the above line, all others
already get it right.

> +	default n
> +	---help---

n is the default default, you can just remove it.

> +	Builds Logic for interfacing with Opal enabled controllers.
> +	Enabling this option enables users to setup/unlock/lock
> +	Locking ranges for SED devices using the Opal protocol.
> +	Currently enables support on NVMe devices.

I'd drop that last line, it's just guaranteed to get stale quickly.

> +/* Enum to index OPALUID array */
> +enum OPAL_UID {

Can you switch all the type names to lower case, e.g. opal_uid
for this one.  I though I rought this up earlier, but it might have
gotten lost between all the more important comments.

Note this only applies to the enum and struct type names, not the
constants defined in the enum, those are usually all upper case by
convention as in your code.

Also the arrays might want to use named initalizers to make the relation
to the indices more clear, e.g.

	[OPAL_SMUID_UID] =
		{ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff},
	...

It's a bit more verbose, but also more future-proof.  And it probably
allows you to drop the comments explaining each array member.

> + * Structures to build and decode the Opal SSC messages
> + * fields that are NOT really numeric are defined as u8[] to
> + * help reduce the endianness issues
> + */

That's normal in all on disk / protocol defintions.  I personally
would just drop this comment, but it's not really a major issue.

> +static const u8 OPALUID[][8] = {

Variable names should be lower cases, too.  Also the magic 8 here
is OPAL_UID_LENGTH, isn't it?

> +struct opal_dev;

We don't need the forward delcaration here, do we?

> +{
> +	bool found_com_id = false, supported = true, single_user = false;
> +	const struct d0_header *hdr;
> +	const u8 *epos, *cpos;
> +	u16 comid = 0;
> +
> +	epos = dev->resp;
> +	cpos = dev->resp;
> +	hdr = (struct d0_header *)dev->resp;

Shouldn't need the cast, and could be assigned in the variable
declaration line.  The same thing appears in various other functions
below.

> + * struct opal_dev - The structure representing a OPAL enabled SED.
> + * @supported: Whether or not OPAL is supported on this controller.
> + * @send_recv: The combined sec_send/sec_recv function pointer.
> + * @opal_step: A series of opal methods that are necessary to complete a command.
> + * @func_data: An array of parameters for the opal methods above.
> + * @state: Describes the current opal_step we're working on.
> + * @dev_lock: Locks the entire opal_dev structure.
> + * @parsed: Parsed response from controller.
> + * @prev_data: Data returned from a method to the controller.
> + * @unlk_lst: A list of Locking ranges to unlock on this device during a resume.
> + */
> +struct opal_dev {

It seems like the driver only needs the struct defintion for looking
at the initialized and supported flags, as well as to use container_of
to get back to containing structure.

I wonder if it might be better to keep the defintion private after
all (and I probably suggested something else earlier, but so much
changed since then).

I suggest you keep it as-is for now and I'll look into an incremental
patch to change it on top yours to make sure the code goes in this
window.

> +int opal_save(struct opal_dev *dev, struct opal_lock_unlock *lk_unlk);
> +int opal_lock_unlock(struct opal_dev *dev, struct opal_lock_unlock *lk_unlk);

...

These don't seem to be used anywhere outside of sed-opal.c, so
please drop the prototypes and mark the functions static.

> +#ifdef CONFIG_BLK_SED_OPAL
> +static inline int is_sed_ioctl(unsigned int cmd)

This should return a bool value.
