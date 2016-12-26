require 'test_helper'

class ReceiptsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @receipt = receipts(:one)
  end

  test "should get index" do
    get receipts_url
    assert_response :success
  end

  test "should get new" do
    get new_receipt_url
    assert_response :success
  end

  test "should create receipt" do
    assert_difference('Receipt.count') do
      post receipts_url, params: { receipt: { article: @receipt.article, article_color: @receipt.article_color, article_flaw: @receipt.article_flaw, article_size: @receipt.article_size, customer_id: @receipt.customer_id, customer_notice: @receipt.customer_notice, order_date: @receipt.order_date, order_receiving: @receipt.order_receiving, producer: @receipt.producer, purchase_date: @receipt.purchase_date, receipt_date: @receipt.receipt_date, receipt_notes: @receipt.receipt_notes, receipt_number: @receipt.receipt_number, receipt_person: @receipt.receipt_person, receipt_true: @receipt.receipt_true, receipt_type: @receipt.receipt_type, receipt_type: @receipt.receipt_type, type_id: @receipt.type_id } }
    end

    assert_redirected_to receipt_url(Receipt.last)
  end

  test "should show receipt" do
    get receipt_url(@receipt)
    assert_response :success
  end

  test "should get edit" do
    get edit_receipt_url(@receipt)
    assert_response :success
  end

  test "should update receipt" do
    patch receipt_url(@receipt), params: { receipt: { article: @receipt.article, article_color: @receipt.article_color, article_flaw: @receipt.article_flaw, article_size: @receipt.article_size, customer_id: @receipt.customer_id, customer_notice: @receipt.customer_notice, order_date: @receipt.order_date, order_receiving: @receipt.order_receiving, producer: @receipt.producer, purchase_date: @receipt.purchase_date, receipt_date: @receipt.receipt_date, receipt_notes: @receipt.receipt_notes, receipt_number: @receipt.receipt_number, receipt_person: @receipt.receipt_person, receipt_true: @receipt.receipt_true, receipt_type: @receipt.receipt_type, receipt_type: @receipt.receipt_type, type_id: @receipt.type_id } }
    assert_redirected_to receipt_url(@receipt)
  end

  test "should destroy receipt" do
    assert_difference('Receipt.count', -1) do
      delete receipt_url(@receipt)
    end

    assert_redirected_to receipts_url
  end
end
