From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 30 May 2017 14:15:48 +0300
Subject: [PATCH v2 2/2] IB/mlx5: set UMR wqe fence according to HCA cap
In-Reply-To: <700d9410-56e7-d70f-9de4-87e4e37bca28@grimberg.me>
References: <1495957991-19223-1-git-send-email-maxg@mellanox.com>
 <1495957991-19223-2-git-send-email-maxg@mellanox.com>
 <700d9410-56e7-d70f-9de4-87e4e37bca28@grimberg.me>
Message-ID: <9562e253-bc15-4ea1-3880-0430fd540410@mellanox.com>



On 5/30/2017 1:48 PM, Sagi Grimberg wrote:
>> +static u8 mlx5_get_umr_fence(u8 umr_fence_cap)
>> +{
>> +    switch (umr_fence_cap) {
>> +    case MLX5_CAP_UMR_FENCE_NONE:
>> +        return MLX5_FENCE_MODE_NONE;
>> +    case MLX5_CAP_UMR_FENCE_SMALL:
>> +        return MLX5_FENCE_MODE_INITIATOR_SMALL;
>> +    default:
>> +        return MLX5_FENCE_MODE_STRONG_ORDERING;
>> +    }
>> +}
>
> Where are the MLX5_CAP_UMR defines declared? Am I missing something?
>
> What is the value of MLX5_CAP_UMR_FENCE_NONE? if its zero then this
> change is not backwards compatible with older FW.


they are declared in patch 1/2:

+enum {
+	MLX5_CAP_UMR_FENCE_STRONG	= 0x0,
+	MLX5_CAP_UMR_FENCE_SMALL	= 0x1,
+	MLX5_CAP_UMR_FENCE_NONE		= 0x2,
+};
+

Thanks,
Max.
