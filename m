From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Tue, 11 Jul 2017 22:07:01 +0000
Subject: [PATCH v7 for-4.13 4/7] RDMA/core: expose affinity mappings per
 completion vector
In-Reply-To: <1499671054-23899-5-git-send-email-sagi@grimberg.me>
References: <1499671054-23899-1-git-send-email-sagi@grimberg.me>
 <1499671054-23899-5-git-send-email-sagi@grimberg.me>
Message-ID: <1499810819.2586.43.camel@wdc.com>

On Mon, 2017-07-10@10:17 +0300, Sagi Grimberg wrote:
>  struct ib_client {
> @@ -3612,7 +3614,6 @@ static inline void rdma_ah_set_interface_id(struct rdma_ah_attr *attr,
>  
>  	grh->dgid.global.interface_id = if_id;
>  }
> -
>  static inline void rdma_ah_set_grh(struct rdma_ah_attr *attr,
>  				   union ib_gid *dgid, u32 flow_label,
>  				   u8 sgid_index, u8 hop_limit,

Hello Sagi,

A nit: is it on purpose that this patch removes a blank line between the
definitions of rdma_ah_set_interface_id() and rdma_ah_set_grh()?

Bart.
