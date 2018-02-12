From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Mon, 12 Feb 2018 09:40:37 +0800
Subject: [PATCH 2/9] nvme: fix the deadlock in nvme_update_formats
In-Reply-To: <6cc12ce7-07ca-35ac-0bae-c6d875854504@grimberg.me>
References: <1518341920-1060-1-git-send-email-jianchao.w.wang@oracle.com>
 <1518341920-1060-3-git-send-email-jianchao.w.wang@oracle.com>
 <6cc12ce7-07ca-35ac-0bae-c6d875854504@grimberg.me>
Message-ID: <a74830c3-ae4e-68ca-866d-669c7007e2c4@oracle.com>

Hi Sagi

Thanks for your kindly response and directive.
That's really appreciated.

On 02/11/2018 07:16 PM, Sagi Grimberg wrote:
>> ????? mutex_lock(&ctrl->namespaces_mutex);
>> ????? list_for_each_entry(ns, &ctrl->namespaces, list) {
>> -??????? if (ns->disk && nvme_revalidate_disk(ns->disk))
>> -??????????? nvme_ns_remove(ns);
>> +??????? if (ns->disk && nvme_revalidate_disk(ns->disk)) {
>> +??????????? list_del_init(&ns->list);
>> +??????????? list_add_tail(&ns->list, &rm_list);
> 
> list_move_tail?

Yes, I will use this interface next version, as well as the 1st patch.

Sincerely
Jianchao

> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_linux-2Dnvme&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=w-s8SrsXdziNNWDrav4KevPTjbt0WNbNQsEmXKL--FY&s=o0wVdE60HzA9inklf3xGMxQjy6l6JHNoDICmOHDBZMA&e=
> 
