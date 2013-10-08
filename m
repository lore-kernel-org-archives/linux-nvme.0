From: vishal.l.verma@intel.com (Verma, Vishal L)
Date: Tue, 8 Oct 2013 18:29:11 +0000
Subject: [PATCH] NVMe: compat SG_IO ioctl
In-Reply-To: <1380316155-2165-1-git-send-email-keith.busch@intel.com>
Message-ID: <CE799566.F7F6%vishal.l.verma@intel.com>

On 9/27/13 3:09 PM, "Keith Busch" <keith.busch@intel.com> wrote:

>I hear some people have (and use!) 32-bit versions of sg3-utils on
>64-bit OSes.  This is pretty much a straight copy from fs/compat_ioctl.c.
>
>Signed-off-by: Keith Busch <keith.busch at intel.com>
>---
> drivers/block/nvme-core.c |   14 +++++-
> drivers/block/nvme-scsi.c |  111
>+++++++++++++++++++++++++++++++++++++++++++++
> include/linux/nvme.h      |    1 +
> 3 files changed, 125 insertions(+), 1 deletion(-)

<snip>

>
>+
>+int nvme_sg_io32(struct nvme_ns *ns, unsigned long arg)
>+{
>+	sg_io_hdr32_t __user *sgio32 = (sg_io_hdr32_t __user *)arg;
>+	sg_io_hdr_t __user *sgio;
>+	u16 iovec_count;
>+	u32 data;
>+	void __user *dxferp;
>+	unsigned char __user *cmdp;
>+	unsigned char __user *sbp;
>+	unsigned char __user *new;
>+	unsigned char __user *top;
>+	
>+	if (get_user(iovec_count, &sgio32->iovec_count))
>+		return -EFAULT;
>+
>+	top = compat_alloc_user_space(0);
>+	new = compat_alloc_user_space(sizeof(sg_io_hdr_t) +
>+			       (iovec_count * sizeof(sg_iovec_t)));
>+	if (new > top)
>+		return -EINVAL;
>+
>+	sgio = (sg_io_hdr_t __user *)new;
>+	if (copy_in_user(&sgio->interface_id, &sgio32->interface_id,
>+							 (2 * sizeof(int)) +
>+							 (2 * sizeof(unsigned char)) +
>+							 (1 * sizeof(unsigned short)) +
>+							 (1 * sizeof(unsigned int))))
>+		return -EFAULT;
>+	if (get_user(data, &sgio32->dxferp))
>+		return -EFAULT;
>+
>+	dxferp = compat_ptr(data);
>+	if (iovec_count && sg_build_iovec(sgio, dxferp, iovec_count))
>+			return -EFAULT;
>+	else if (put_user(dxferp, &sgio->dxferp))
>+			return -EFAULT;
>+
>+	if (get_user(data, &sgio32->cmdp))
>+		return -EFAULT;
>+
>+	cmdp = compat_ptr(data);
>+	if (get_user(data, &sgio32->sbp))
>+		return -EFAULT;
>+
>+	sbp = compat_ptr(data);
>+	if (put_user(cmdp, &sgio->cmdp) || put_user(sbp, &sgio->sbp))
>+		return -EFAULT;
>+	if (copy_in_user(&sgio->timeout, &sgio32->timeout, 3 * sizeof(int)))
>+		return -EFAULT;
>+	if (get_user(data, &sgio32->usr_ptr))
>+		return -EFAULT;
>+	if (put_user(compat_ptr(data), &sgio->usr_ptr))
>+		return -EFAULT;
>+
>+	return nvme_sg_io(ns, sgio);

This should copy status and sbp/sb_len_wr from sgio back into sgio32
before returning.

>+}
>+
> int nvme_sg_get_version_num(int __user *ip)
> {
> 	return put_user(sg_version_num, ip);
>diff --git a/include/linux/nvme.h b/include/linux/nvme.h
>index 26ebcf4..6867de6 100644
>--- a/include/linux/nvme.h
>+++ b/include/linux/nvme.h
>@@ -165,6 +165,7 @@ int nvme_set_features(struct nvme_dev *dev, unsigned
>fid, unsigned dword11,
> struct sg_io_hdr;
> 
> int nvme_sg_io(struct nvme_ns *ns, struct sg_io_hdr __user *u_hdr);
>+int nvme_sg_io32(struct nvme_ns *ns, unsigned long arg);
> int nvme_sg_get_version_num(int __user *ip);
> 
> #endif /* _LINUX_NVME_H */
>-- 
>1.7.10.4
>

Thanks,
-Vishal

>
>_______________________________________________
>Linux-nvme mailing list
>Linux-nvme at lists.infradead.org
>http://merlin.infradead.org/mailman/listinfo/linux-nvme
>
