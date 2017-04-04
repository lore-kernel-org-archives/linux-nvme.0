From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 4 Apr 2017 13:46:09 +0300
Subject: [RFC 4/8] p2pmem: Add debugfs "stats" file
In-Reply-To: <1490911959-5146-5-git-send-email-logang@deltatee.com>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
 <1490911959-5146-5-git-send-email-logang@deltatee.com>
Message-ID: <95928b70-0148-7297-8f5e-5031d996bb98@grimberg.me>


> +	p2pmem_debugfs_root = debugfs_create_dir("p2pmem", NULL);
> +	if (!p2pmem_debugfs_root)
> +		pr_info("could not create debugfs entry, continuing\n");
> +

Why continue? I think it'd be better to just fail it.

Besides, this can be safely squashed into patch 1.
