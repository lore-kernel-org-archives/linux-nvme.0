From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 21 Nov 2018 14:27:16 -0800
Subject: [PATCH v2 14/14] nvme-tcp: add NVMe over TCP host driver
In-Reply-To: <20181121085645.GA29747@lst.de>
References: <20181120030019.31738-1-sagi@grimberg.me>
 <20181120030019.31738-16-sagi@grimberg.me> <20181121085645.GA29747@lst.de>
Message-ID: <09c340a0-0b7f-ff9b-f196-7ba48a0ee234@grimberg.me>


>> +struct nvme_tcp_send_ctx {
>> +	struct bio		*curr_bio;
>> +	struct iov_iter		iter;
>> +	size_t			offset;
>> +	size_t			data_sent;
>> +	enum nvme_tcp_send_state state;
>> +};
>> +
>> +struct nvme_tcp_recv_ctx {
>> +	struct iov_iter		iter;
>> +	struct bio		*curr_bio;
>> +};
> 
> I don't understand these structures.  There should only be
> a bio to be send or receive, not both.  Why do we need two
> curr_bio pointers?

We don't really need both...

> To me it seems like both structures should just go away and
> move into nvme_tcp_request ala:
> 
> 
> 	struct bio		*curr_bio;
> 
> 	/* send state */
> 	struct iov_iter		send_iter;
> 	size_t			send_offset;
> 	enum nvme_tcp_send_state send_state;
> 	size_t			data_sent;
> 
> 	/* receive state */
> 	struct iov_iter		recv_iter;
> 

Sure, will move this.
