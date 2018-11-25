From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 25 Nov 2018 01:13:00 -0800
Subject: [PATCH v3 11/13] nvmet-tcp: add NVMe over TCP target driver
In-Reply-To: <20181122090655.GA27707@lst.de>
References: <20181122015615.15763-1-sagi@grimberg.me>
 <20181122015615.15763-12-sagi@grimberg.me> <20181122090655.GA27707@lst.de>
Message-ID: <4375f088-6afa-e0e6-1fdb-51359741660c@grimberg.me>


>> +	if (!cmd || queue->state == NVMET_TCP_Q_DISCONNECTING) {
>> +		cmd = nvmet_tcp_fetch_send_command(queue);
>> +		if (unlikely(!cmd))
>> +			return 0;
>> +	}
>> +
>> +	if (cmd->state == NVMET_TCP_SEND_DATA_PDU) {
>> +		ret = nvmet_try_send_data_pdu(cmd);
>> +		if (ret <= 0)
>> +			goto done_send;
>> +	}
>> +
>> +	if (cmd->state == NVMET_TCP_SEND_DATA) {
>> +		ret = nvmet_try_send_data(cmd);
>> +		if (ret <= 0)
>> +			goto done_send;
>> +	}
>> +
>> +	if (cmd->state == NVMET_TCP_SEND_DDGST) {
>> +		ret = nvmet_try_send_ddgst(cmd);
>> +		if (ret <= 0)
>> +			goto done_send;
>> +	}
>> +
>> +	if (cmd->state == NVMET_TCP_SEND_R2T) {
>> +		ret = nvmet_try_send_r2t(cmd, last_in_batch);
>> +		if (ret <= 0)
>> +			goto done_send;
>> +	}
>> +
>> +	if (cmd->state == NVMET_TCP_SEND_RESPONSE)
>> +		ret = nvmet_try_send_response(cmd, last_in_batch);
> 
> Use a switch statement?

The intent would be such that the state would transition with
the progression of the routine...

...

The rest of the comments will be addressed in the next submission..
