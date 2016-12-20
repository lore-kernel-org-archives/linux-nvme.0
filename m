From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 19 Dec 2016 23:28:47 -0800
Subject: [PATCH v3 2/5] lib: Add Sed-opal library
In-Reply-To: <1482176149-2257-3-git-send-email-scott.bauer@intel.com>
References: <1482176149-2257-1-git-send-email-scott.bauer@intel.com>
 <1482176149-2257-3-git-send-email-scott.bauer@intel.com>
Message-ID: <20161220072847.GA11946@infradead.org>

> +	u8 lr;
> +	size_t key_name_len;
> +	char key_name[36];

Who is going to use the key_name?  I can't find another reference to
it anywhere else in the code.   The reason why this tripped me off was
the hardcoded length so I was going to check on how access to it is
bounds checked.

> +/**
> + * struct opal_dev - The structure representing a OPAL enabled SED.
> + * @sed_ctx:The SED context, contains fn pointers to sec_send/recv.
> + * @opal_step:A series of opal methods that are necessary to complete a comannd.
> + * @func_data:An array of parameters for the opal methods above.
> + * @state:Describes the current opal_step we're working on.
> + * @dev_lock:Locks the entire opal_dev structure.
> + * @parsed:Parsed response from controller.
> + * @prev_data:Data returned from a method to the controller
> + * @error_cb:Error function that handles closing sessions after a failed method.
> + * @unlk_lst:A list of Locking ranges to unlock on this device during a resume.
> + */

Needs spaces after the colons.

> +	u16 comID;
> +	u32 HSN;
> +	u32 TSN;

Please use lower case variable names in Linux code, and separate
words by underscores if needed.

> +DEFINE_SPINLOCK(list_spinlock);

Should be marked static.

> +#define TPER_SYNC_SUPPORTED BIT(0)

This sounds like a protocol constant and should go into the header
with the rest of the protocol.

> +static bool check_tper(const void *data)
> +{
> +	const struct d0_tper_features *tper = data;
> +	u8 flags = tper->supported_features;
> +
> +	if (!(flags & TPER_SYNC_SUPPORTED)) {
> +		pr_err("TPer sync not supported. flags = %d\n",
> +		       tper->supported_features);

It would be great to use dev_err / dev_warn / etc in the opal code,
although for that you'll need to pass a struct device from the driver
into the code.

> +static bool check_SUM(const void *data)

The comment on member naming above also applies to variables and function
names.

> +	bool foundComID = false, supported = true, single_user = false;
> +	const struct d0_header *hdr;
> +	const u8 *epos, *cpos;
> +	u16 comID = 0;
> +	int error = 0;
> +
> +	epos = dev->cmd.resp;
> +	cpos = dev->cmd.resp;
> +	hdr = (struct d0_header *)dev->cmd.resp;

You probably want to structure your command buffers to use void pointers
and avoid ths kind of casting.

> +#define TINY_ATOM_DATA_MASK GENMASK(5, 0)
> +#define TINY_ATOM_SIGNED BIT(6)
> +
> +#define SHORT_ATOM_ID BIT(7)
> +#define SHORT_ATOM_BYTESTRING BIT(5)
> +#define SHORT_ATOM_SIGNED BIT(4)
> +#define SHORT_ATOM_LEN_MASK GENMASK(3, 0)

Protocol constants for the header again?

> +#define ADD_TOKEN_STRING(cmd, key, keylen)		        \
> +	if (!err)					        \
> +		err = test_and_add_string(cmd, key, keylen);
> +
> +#define ADD_TOKEN(type, cmd, tok)				\
> +	if (!err)						\
> +		err = test_and_add_token_##type(cmd, tok);

Please remove these macros and just open code the calls.  If you want
to avoid writing the if err lines again and again just pass err
by reference to the functions and move the err check into the add_token*
helpers.

> +	if ((hdr->cp.length == 0)
> +	    || (hdr->pkt.length == 0)
> +	    || (hdr->subpkt.length == 0)) {

No need for the inner braces, also please place the operators at the
end of the previous line instead of the beginning of the new line.

> +	while (cpos < total) {
> +		if (!(pos[0] & 0x80)) /* tiny atom */
> +			token_length = response_parse_tiny(iter, pos);
> +		else if (!(pos[0] & 0x40)) /* short atom */
> +			token_length = response_parse_short(iter, pos);
> +		else if (!(pos[0] & 0x20)) /* medium atom */
> +			token_length = response_parse_medium(iter, pos);
> +		else if (!(pos[0] & 0x10)) /* long atom */
> +			token_length = response_parse_long(iter, pos);

Please add symbolic names for these constants to the protocol header.

> +	if (num_entries == 0) {
> +		pr_err("Couldn't parse response.\n");
> +		return -EINVAL;
> +	resp->num = num_entries;

Where is the closing brace for that if?

> +	if (!((resp->toks[n].width == OPAL_WIDTH_TINY) ||
> +	      (resp->toks[n].width == OPAL_WIDTH_SHORT))) {

No need for the inner braces.

> +		pr_err("Atom is not short or tiny: %d\n",
> +		       resp->toks[n].width);
> +		return 0;
> +	}
> +
> +	return resp->toks[n].stored.u;
> +}
> +
> +static u8 response_status(const struct parsed_resp *resp)
> +{
> +	if ((token_type(resp, 0) == OPAL_DTA_TOKENID_TOKEN)
> +	    && (response_get_token(resp, 0) == OPAL_ENDOFSESSION)) {

Same here, also please fix the operator placement.

> +	if ((token_type(resp, resp->num - 1) != OPAL_DTA_TOKENID_TOKEN) ||
> +	    (token_type(resp, resp->num - 5) != OPAL_DTA_TOKENID_TOKEN) ||
> +	    (response_get_token(resp, resp->num - 1) != OPAL_ENDLIST) ||
> +	    (response_get_token(resp, resp->num - 5) != OPAL_STARTLIST))

More brace removal here please (and probably a lot more later on, I'm
going to skip them from here)

> +static inline void opal_dev_get(struct opal_dev *dev)
> +{
> +	mutex_lock(&dev->dev_lock);
> +}
> +
> +static inline void opal_dev_put(struct opal_dev *dev)
> +{
> +	mutex_unlock(&dev->dev_lock);
> +}

No trivial wrappers around locking primitives, please.

> +static int add_suspend_info(struct opal_dev *dev, struct opal_suspend_data *sus)
> +{
> +	struct opal_suspend_data *iter;
> +	bool found = false;
> +
> +	if (list_empty(&dev->unlk_lst))
> +		goto add_out;
> +
> +	list_for_each_entry(iter, &dev->unlk_lst, node) {

list_for_each_entry will do the right thing for an empty
list, you can remove the above check,

> +		if (iter->lr == sus->lr) {
> +			found = true;
> +			break;
> +		}
> +	}
> +
> +	if (found) {
> +		/* Replace the old with the new */
> +		list_del(&iter->node);
> +		kfree(iter);
> +	}

Just move the list_del and kfree inside the if above and you
can remove the found variable.

> +
> +int activate_lsp(struct opal_dev *dev)

static?

> +static int get_msid_cpin_pin_cont(struct opal_dev *dev)
> +{
> +	const char *msid_pin;
> +	size_t strlen;
> +	int error = 0;
> +
> +	error = parse_and_check_status(dev);
> +	if (error)
> +		return error;
> +
> +	strlen = response_get_string(&dev->parsed, 4, &msid_pin);
> +	if (!msid_pin) {
> +		pr_err("%s: Couldn't extract PIN from response\n", __func__);
> +		return 11;

please add constant for your magic return values.

> +	}
> +
> +	dev->prev_data = kmemdup(msid_pin, strlen, GFP_KERNEL);
> +	if (!dev->prev_data)
> +		return -ENOMEM;
> +
> +	dev->prev_d_len = strlen;
> +
> + err_return:
> +	return 0;

I can't find anything actually jumping to this label.  And if it did
it could just return directly.

> +
> +static struct opal_dev *get_opal_dev(struct sed_context *sedc,
> +				     const opal_step *funcs)
> +{
> +	struct opal_dev *dev = sedc->dev;
> +	if (dev) {
> +		dev->state = 0;
> +		dev->funcs = funcs;
> +		dev->TSN = 0;
> +		dev->HSN = 0;
> +		dev->error_cb = end_opal_session_error;
> +		dev->error_cb_data = dev;
> +		dev->func_data = NULL;
> +		dev->sed_ctx = sedc;
> +		opal_dev_get(dev);
> +	}
> +	return dev;

Who serialized access to sedv->dev?

> +	struct opal_dev *dev;
> +	void *data[3] = { NULL };
> +	const opal_step erase_funcs[] = {
> +		opal_discovery0,
> +		start_auth_opal_session,
> +		get_active_key,
> +		gen_key,
> +		end_opal_session,
> +		NULL,
> +	};

static?

> +EXPORT_SYMBOL(opal_enable_disable_shadow_mbr);

As far as I can tell nothing but alloc_opal_dev and
opal_unlock_from_suspend is every called from another module,
so all these exports could be dropped.


> +	struct opal_dev *dev;
> +		const opal_step funcs[] = {

wrong indentation.  also all these arrays of functions should be
marked static.

> +	if (!list_empty(&dev->unlk_lst)) {
> +		list_for_each_entry(suspend, &dev->unlk_lst, node) {

No need for the list_empty check.

> --- /dev/null
> +++ b/lib/sed-opal_internal.h

This pretty much seem to contain the OPAL protocol defintions, so why
not opal_proto.h?

> +#ifndef _NVME_OPAL_INTERNAL_H
> +#define _NVME_OPAL_INTERNAL_H

And this doesn't seem to match the file name.

> +#include <linux/key-type.h>
> +#include <keys/user-type.h>

These don't seem to be needed.

> +/*
> + * Derived from:
> + * TCG_Storage_Architecture_Core_Spec_v2.01_r1.00
> + * Section: 5.1.5 Method Status Codes
> + */
> +static const char *opal_errors[] = {

static consta char * const opal_errors[] = {

also please move this into a .c file so that it's not duplicated
in every file that includes the header.

> +static const char *opal_error_to_human(int error)
> +{
> +	if (error == 0x3f)
> +		return "Failed";
> +
> +	if (error >= ARRAY_SIZE(opal_errors) || error < 0)
> +		return "Unknown Error";
> +
> +	return opal_errors[error];
> +}

Same for this one.

> +/*
> + * User IDs used in the TCG storage SSCs
> + * Derived from: TCG_Storage_Architecture_Core_Spec_v2.01_r1.00
> + * Section: 6.3 Assigned UIDs
> + */
> +static const u8 OPALUID[][8] = {

And all the other following variable delcarations.

Also please use lower case names with underscores as separators
for your variable and type names.  Constants can remain in all caps.

> +static const size_t OPAL_UID_LENGTH = 8;
> +static const size_t OPAL_MSID_KEYLEN = 15;
> +static const size_t OPAL_UID_LENGTH_HALF = 4;

Use a #define or enum fo these constants.


> +struct key *request_user_key(const char *master_desc, const u8 **master_key,
> +			     size_t *master_keylen);

This one doesn't actually seem to be used.

> +int sed_save(struct sed_context *sed_ctx, struct sed_key *key)
> +{
> +	switch (key->sed_type) {
> +	case OPAL_LOCK_UNLOCK:
> +		return opal_save(sed_ctx, key);
> +	}
> +
> +	return -EOPNOTSUPP;

It seems to me that we should skip this whole sed_type indirections
and just specify the ioctls directly for OPAL (which would include
opalite and pyrite as subsets).  The only other protocols of interest
for Linux would be the ATA "security" plain text passwords, which can
be handled differently, or enterprise SSC which we can hopefully avoid
to implement entirely.

> +
> +int fdev_sed_ioctl(struct file *filep, unsigned int cmd,
> +		   unsigned long arg)
> +{
> +	struct sed_key key;
> +	struct sed_context *sed_ctx;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EACCES;
> +
> +	if (!filep->f_sedctx || !filep->f_sedctx->ops || !filep->f_sedctx->dev)
> +		return -ENODEV;

In the previous version this was called from the block driver which
could pass in the context (and ops).  Why was this changed?
