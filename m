From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 23 Apr 2017 17:35:56 +0300
Subject: [PATCH v2 0/4] arbitrary sg lists support
In-Reply-To: <9a9668fa-87a7-e730-27e2-8a2b3e7fbc36@mellanox.com>
References: <1492098977-5231-1-git-send-email-maxg@mellanox.com>
 <1492101079.5176.9.camel@sandisk.com>
 <c52b5ce7-5346-419d-26f2-0d4d45d20471@grimberg.me>
 <20170423103439.GC14088@mtr-leonro.local>
 <d697d360-99ca-c3ed-08e2-b89cc50a15b0@grimberg.me>
 <20170423121254.GD14088@mtr-leonro.local>
 <a3264968-2d9e-bda5-1f23-74da248cf4d5@grimberg.me>
 <9a9668fa-87a7-e730-27e2-8a2b3e7fbc36@mellanox.com>
Message-ID: <8ed506ba-ae7b-af27-2d2a-9a434c22353c@grimberg.me>


> I actually answered here:
> https://www.spinics.net/lists/linux-rdma/msg46412.html

Did anything progress with the debug?

> Sagi,
> As you mentioned the IO path is different in SRP and iSER so IMO we
> should start with SRP debugging. NVMf is similar to iSER (and not SRP)
> and that's why I think we can apply this patchset.

My concern is that this might be broken due to the fact that we don't
know what triggers this.

> If you want to wait till we debug SRP issue it's fine, but I can't repro
> it in my lab so it can take longer.

I'd prefer not to take a non-mandatory feature that is not guaranteed
to work.

> Lourance,
> maybe you can update your FW to the latest CX4 from our site and try to
> repro this issue ?

Laurence,

Can you please enable srp_add_one debug:

echo "func srp_add_one +p" > /sys/kernel/debug/dynamic_debug/control

In addition apply the following:
--
diff --git a/drivers/infiniband/hw/mlx5/mr.c 
b/drivers/infiniband/hw/mlx5/mr.c
index d9c6c0ea750b..040fbc387e4f 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1403,6 +1403,8 @@ mlx5_alloc_priv_descs(struct ib_device *device,
         int add_size;
         int ret;

+       WARN_ON_ONCE(ndescs > device->attr.max_fast_reg_page_list_len);
+
         add_size = max_t(int, MLX5_UMR_ALIGN - ARCH_KMALLOC_MINALIGN, 0);

         mr->descs_alloc = kzalloc(size + add_size, GFP_KERNEL);
--

Cheers,
Sagi.
