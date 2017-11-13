From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 13 Nov 2017 22:32:05 +0200
Subject: [PATCH v3 0/9] Introduce per-device completion queue pools
In-Reply-To: <20171109185239.GL18825@mtr-leonro.local>
References: <20171108095742.25365-1-sagi@grimberg.me>
 <1510245771.2608.6.camel@wdc.com>
 <d5820b65-b428-7cd1-f7f1-7d8d89d21cf5@grimberg.me>
 <20171109185239.GL18825@mtr-leonro.local>
Message-ID: <562c3855-84ab-e52e-570d-a11757f166cd@grimberg.me>

Hey Leon,

>>> Additionally, on many setups each
>>> RDMA port only runs a single ULP. I think that's another argument to let the
>>> ULP allocate CQ pool(s) instead of having one such pool per HCA.
>>
>> I think that most modern HCAs are exposing device-per-port and will
>> probably continue to do so, But yes, mlx4 is dual-ported HCA.
> 
> I have patches in my queue for -next cycle which introduce similar
> functionality for mlx5 too - one mlx5_ib device with two ports.

Thanks for the heads up.
