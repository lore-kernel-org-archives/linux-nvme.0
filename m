From: keith.busch@intel.com (Keith Busch)
Date: Thu, 22 Jan 2015 19:26:29 +0000 (UTC)
Subject: [PATCH] NVMe: avoid kmalloc/kfree for smaller IO
In-Reply-To: <CANvN+enF8Btab2NbuALyzRfpmkfR0ibRVbfCt-ZxWdW9vt9AmA@mail.gmail.com>
References: <20150122043805.GA12546@kernel.dk>
 <alpine.LNX.2.00.1501221702170.15481@localhost.lm.intel.com>
 <CANvN+end4BQMAeBZKggbA8k+gjQzKj2xYx+=hovbTvmK_GH4Ug@mail.gmail.com>
 <alpine.LNX.2.00.1501221823430.15481@localhost.lm.intel.com>
 <CANvN+emqnrm1YE2Ft68=Q+aMBgDUVEUhHUTfPwPM=yBX-EhtHg@mail.gmail.com>
 <alpine.LNX.2.00.1501221840120.15481@localhost.lm.intel.com>
 <CANvN+enF8Btab2NbuALyzRfpmkfR0ibRVbfCt-ZxWdW9vt9AmA@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1501221910090.15481@localhost.lm.intel.com>

On Thu, 22 Jan 2015, Andrey Kuzmin wrote:
> According to 1.2 (that's what I've got at hand, see the quote below), controller reports min/max supported page size, and the host then sets memory page size (via CC.MPS register) within the reported limits. So those negotiations
> should be in charge of setting and storing the page size, whereupon Jens's code can just utilize the setting the driver has applied to CC.MPS.

Right, and that was the suggestion. :)

The spec doesn't call this out, but the host can set CC.MPS to any value
in the controller's capable range as long as that value is less than or
equal to the host's true size.

... actually you could probably make it work the other way around (host
size smaller than the device's), but that'd force a lot of IO splitting
and no such device exists anyway.

> 3.1.5 Offset 14h: CC ? Controller Configuration
> This register modifies settings for the controller. Host software shall set the Arbitration Mechanism
> (CC.AMS), the Memory Page Size (CC.MPS), and the Command Set (CC.CSS) to valid values prior to
> enabling the controller by setting CC.EN to ?1?.
> 
> Memory Page Size (MPS): This field indicates the host memory page size.
> The memory page size is (2 ^ (12 + MPS)). Thus, the minimum host memory page size is 4KB and the maximum host memory page size is 128MB. The
> value set by host software shall be a supported value as indicated by the CAP.MPSMAX and CAP.MPSMIN fields. This field describes the value used for PRP entry size. This field shall only be modified when EN is cleared to ?0?.
