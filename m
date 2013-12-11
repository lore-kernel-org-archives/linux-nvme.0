From: willy@linux.intel.com (Matthew Wilcox)
Date: Wed, 11 Dec 2013 11:43:42 -0500
Subject: [PATCH 1/1] block: nvme-core: Scatter gather list support in the
 NVMe Block Driver
In-Reply-To: <1386778908-3370-1-git-send-email-smrajiv15@gmail.com>
References: <1386778908-3370-1-git-send-email-smrajiv15@gmail.com>
Message-ID: <20131211164342.GJ6900@linux.intel.com>

On Wed, Dec 11, 2013@09:51:48PM +0530, Rajiv Shanmugam Madeswaran wrote:
> Present nvme block driver supports PRP mode of data transfer for Admin
> and I/O commands. As per NVMe specification 1.1a I/O commands can also
> be transferred through SGL.

Yes, they *can*.  But why?  PRPs are more efficient for just about every
use case.

I'm not going to accept a patch which unconditionally uses SGLs.
I'm not convinced of the value of SGLs for Linux (apparently they're
useful for Windows).  I could be talked into a patch which conditionally
uses SGLs if they're more efficient for an individual command.

> @@ -59,6 +59,14 @@ static DEFINE_SPINLOCK(dev_list_lock);
>  static LIST_HEAD(dev_list);
>  static struct task_struct *nvme_thread;
>  
> +static struct nvme_iod*
> +	(*iodfp) (unsigned nseg, unsigned nbytes, gfp_t gfp);
> +
> +static int (*setup_xfer) (struct nvme_dev *dev, struct nvme_common_command *cmd,
> +				struct nvme_iod *iod, int total_len, gfp_t gfp);
> +
> +static void (*free_iod) (struct nvme_dev *dev, struct nvme_iod *iod);

So what happens if you have two controllers in your computer, one of
which supports SGLs and one of which doesn't?

> +struct sgl_desc {
> +	__le64 addr;
> +	__le32  length;
> +	__u8    rsvd[3];
> +	__u8    zero:4;
> +	__u8    sg_id:4;
> +};
> +
> +struct prp_list {
> +	__le64  prp1;
> +	__le64  prp2;
> +};
> +
> +union data_buffer {
> +	struct sgl_desc sgl;
> +	struct prp_list prp;
> +};
> +
>  struct nvme_common_command {
>  	__u8			opcode;
>  	__u8			flags;
> @@ -175,8 +202,7 @@ struct nvme_common_command {
>  	__le32			nsid;
>  	__le32			cdw2[2];
>  	__le64			metadata;
> -	__le64			prp1;
> -	__le64			prp2;
> +	union data_buffer	buffer;
>  	__le32			cdw10[6];
>  };

Probabaly better to use anonymous unions here:

-	__le64			prp1;
-	__le64			prp2;
+	union {
+		struct {
+			__le64	prp1;
+			__le64	prp2;
+		};
+		struct {
+			__le64	addr;
+			__le32  length;
+			__u8    rsvd[3];
+			__u8    sg_id;
+		};
+	};

Note that you shouldn't use bitfields.  The compiler does not necessarily
lay them out the way you expect it to.
