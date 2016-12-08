From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Thu, 8 Dec 2016 13:14:42 +0300
Subject: [bug report] nvme-fabrics: Add host support for FC transport
Message-ID: <20161208101442.GA5354@elgon.mountain>

Hello James Smart,

The patch e399441de911: "nvme-fabrics: Add host support for FC
transport" from Dec 2, 2016, leads to the following static checker
warning:

	drivers/nvme/host/fc.c:1214 nvme_fc_fcpio_done()
	warn: assigning (-5) to unsigned variable 'status'

drivers/nvme/host/fc.c
  1140  void
  1141  nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
  1142  {
  1143          struct nvme_fc_fcp_op *op = fcp_req_to_fcp_op(req);
  1144          struct request *rq = op->rq;
  1145          struct nvmefc_fcp_req *freq = &op->fcp_req;
  1146          struct nvme_fc_ctrl *ctrl = op->ctrl;
  1147          struct nvme_fc_queue *queue = op->queue;
  1148          struct nvme_completion *cqe = &op->rsp_iu.cqe;
  1149          u16 status;
                ^^^^^^^^^^
This is a u16.

  1150  
  1151          /*
  1152           * WARNING:
  1153           * The current linux implementation of a nvme controller
  1154           * allocates a single tag set for all io queues and sizes
  1155           * the io queues to fully hold all possible tags. Thus, the
  1156           * implementation does not reference or care about the sqhd
  1157           * value as it never needs to use the sqhd/sqtail pointers
  1158           * for submission pacing.
  1159           *
  1160           * This affects the FC-NVME implementation in two ways:
  1161           * 1) As the value doesn't matter, we don't need to waste
  1162           *    cycles extracting it from ERSPs and stamping it in the
  1163           *    cases where the transport fabricates CQEs on successful
  1164           *    completions.
  1165           * 2) The FC-NVME implementation requires that delivery of
  1166           *    ERSP completions are to go back to the nvme layer in order
  1167           *    relative to the rsn, such that the sqhd value will always
  1168           *    be "in order" for the nvme layer. As the nvme layer in
  1169           *    linux doesn't care about sqhd, there's no need to return
  1170           *    them in order.
  1171           *
  1172           * Additionally:
  1173           * As the core nvme layer in linux currently does not look at
  1174           * every field in the cqe - in cases where the FC transport must
  1175           * fabricate a CQE, the following fields will not be set as they
  1176           * are not referenced:
  1177           *      cqe.sqid,  cqe.sqhd,  cqe.command_id
  1178           */
  1179  
  1180          fc_dma_sync_single_for_cpu(ctrl->lport->dev, op->fcp_req.rspdma,
  1181                                  sizeof(op->rsp_iu), DMA_FROM_DEVICE);
  1182  
  1183          if (atomic_read(&op->state) == FCPOP_STATE_ABORTED)
  1184                  status = NVME_SC_ABORT_REQ | NVME_SC_DNR;

It's a bit mask that holds error bits like this.

  1185          else
  1186                  status = freq->status;
  1187  
  1188          /*
  1189           * For the linux implementation, if we have an unsuccesful
  1190           * status, they blk-mq layer can typically be called with the
  1191           * non-zero status and the content of the cqe isn't important.
  1192           */
  1193          if (status)
  1194                  goto done;
  1195  
  1196          /*
  1197           * command completed successfully relative to the wire
  1198           * protocol. However, validate anything received and
  1199           * extract the status and result from the cqe (create it
  1200           * where necessary).
  1201           */
  1202  
  1203          switch (freq->rcv_rsplen) {
  1204  
  1205          case 0:
  1206          case NVME_FC_SIZEOF_ZEROS_RSP:
  1207                  /*
  1208                   * No response payload or 12 bytes of payload (which
  1209                   * should all be zeros) are considered successful and
  1210                   * no payload in the CQE by the transport.
  1211                   */
  1212                  if (freq->transferred_length !=
  1213                          be32_to_cpu(op->cmd_iu.data_len)) {
  1214                          status = -EIO;
                                ^^^^^^^^^^^^^
  1215                          goto done;
  1216                  }
  1217                  op->nreq.result.u64 = 0;
  1218                  break;
  1219  
  1220          case sizeof(struct nvme_fc_ersp_iu):
  1221                  /*
  1222                   * The ERSP IU contains a full completion with CQE.
  1223                   * Validate ERSP IU and look at cqe.
  1224                   */
  1225                  if (unlikely(be16_to_cpu(op->rsp_iu.iu_len) !=
  1226                                          (freq->rcv_rsplen / 4) ||
  1227                               be32_to_cpu(op->rsp_iu.xfrd_len) !=
  1228                                          freq->transferred_length ||
  1229                               op->rqno != le16_to_cpu(cqe->command_id))) {
  1230                          status = -EIO;
                                ^^^^^^^^^^^^^^

  1231                          goto done;
  1232                  }
  1233                  op->nreq.result = cqe->result;
  1234                  status = le16_to_cpu(cqe->status) >> 1;
  1235                  break;
  1236  
  1237          default:
  1238                  status = -EIO;
                        ^^^^^^^^^^^^^

So these three assignments should be changed.

  1239                  goto done;
  1240          }
  1241  
  1242  done:
  1243          if (!queue->qnum && op->rqno >= AEN_CMDID_BASE) {
  1244                  nvme_complete_async_event(&queue->ctrl->ctrl, status,
  1245                                          &op->nreq.result);
  1246                  nvme_fc_ctrl_put(ctrl);
  1247                  return;
  1248          }
  1249  
  1250          blk_mq_complete_request(rq, status);
  1251  }

regards,
dan carpenter
