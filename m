From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Tue, 29 Aug 2017 14:54:56 +0800
Subject: [PATCH 07/10] nvme: track shared namespaces
In-Reply-To: <bee7c6c3-bf6b-8f7e-ad8f-fd5e238a94ef@grimberg.me>
References: <20170823175815.3646-1-hch@lst.de>
 <20170823175815.3646-8-hch@lst.de>
 <bee7c6c3-bf6b-8f7e-ad8f-fd5e238a94ef@grimberg.me>
Message-ID: <19cc45b0-1f84-d115-6ae6-2349613c2ca2@huawei.com>



On 2017/8/28 14:51, Sagi Grimberg wrote:
> +static int __nvme_check_ids(struct nvme_subsystem *subsys,
> +        struct nvme_ns_head *new)
> +{
> +    struct nvme_ns_head *h;
> +
> +    lockdep_assert_held(&subsys->lock);
> +
> +    list_for_each_entry(h, &subsys->nsheads, entry) {
> +        if ((!uuid_is_null(&new->uuid) &&
> +             uuid_equal(&new->uuid, &h->uuid)) ||
> +            (memchr_inv(new->nguid, 0, sizeof(new->nguid)) &&
> +             memcmp(&new->nguid, &h->nguid, sizeof(new->nguid))) ||

memcmp() -> !memcmp

> +            (memchr_inv(new->eui64, 0, sizeof(new->eui64)) &&
> +             memcmp(&new->eui64, &h->eui64, sizeof(new->eui64))))

memcmp() -> !memcmp

Otherwise in this patch, looks good.
Reviewed-by: Guan Junxiong <guanjunxiong at huawei.com>
